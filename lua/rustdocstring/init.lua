local M = {}

local ts_utils = require 'nvim-treesitter.ts_utils'
local parsers = require 'nvim-treesitter.parsers'

--- Utility to extract return type as string
local function get_return_type(node, bufnr)
  local ret = node:field('return_type')[1]
  if ret then
    return vim.treesitter.get_node_text(ret, bufnr):gsub('^%s*->%s*', '')
  end
  return nil
end

--- Utility to detect if function is async or unsafe
local function get_modifiers(node)
  local modifiers = {}
  for child in node:iter_children() do
    if child:type() == 'modifier' then
      local text = vim.treesitter.get_node_text(child, 0)
      table.insert(modifiers, text)
    end
  end
  return modifiers
end

function M.insert_docstring()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = parsers.get_parser(bufnr, 'rust')
  local root = parser:parse()[1]:root()
  local node = ts_utils.get_node_at_cursor()

  while node and not vim.tbl_contains({ 'function_item', 'struct_item', 'enum_item' }, node:type()) do
    node = node:parent()
  end

  if not node then
    print 'Not on a recognized Rust item.'
    return
  end

  local doc_lines = {}
  local node_type = node:type()

  if node_type == 'function_item' then
    local name = node:field('name')[1]
    local func_name = name and vim.treesitter.get_node_text(name, bufnr) or 'function'
    local return_type = get_return_type(node, bufnr)
    local modifiers = get_modifiers(node)

    table.insert(doc_lines, '/// Describe this function.')
    table.insert(doc_lines, '///')

    if vim.tbl_contains(modifiers, 'unsafe') then
      table.insert(doc_lines, '/// # Safety')
      table.insert(doc_lines, '///')
      table.insert(doc_lines, '/// - **The caller must ensure that:**')
      table.insert(doc_lines, '///   - Any internal state or memory accessed by this function is in a valid state.')
      table.insert(doc_lines, "///   - Preconditions specific to this function's logic are satisfied.")
      table.insert(doc_lines, '///   - This function is only called in the correct program state to avoid UB.')
      table.insert(doc_lines, '/// - **This function is `unsafe` because:**')
      table.insert(doc_lines, '///   - Describe unsafe behavior.')
      table.insert(doc_lines, '///')
    end

    local params = node:field('parameters')[1]
    if params then
      table.insert(doc_lines, '/// # Arguments')
      table.insert(doc_lines, '///')
      for param in params:iter_children() do
        local pname = param:field('pattern')[1]
        local ptype = param:field('type')[1]
        if pname and ptype then
          local pname_text = vim.treesitter.get_node_text(pname, bufnr)
          local ptype_text = vim.treesitter.get_node_text(ptype, bufnr)
          table.insert(doc_lines, string.format('/// - `%s` (`%s`) - Describe this parameter.', pname_text, ptype_text))
        end
      end
    end

    if return_type then
      table.insert(doc_lines, '///')
      table.insert(doc_lines, '/// # Returns')
      table.insert(doc_lines, '///')
      table.insert(doc_lines, string.format('/// - `%s` - Describe the return value.', return_type))
    end

    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// # Examples')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// ```')
    table.insert(doc_lines, '/// use crate::...;')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, string.format('/// let _ = %s();', func_name))
    table.insert(doc_lines, '/// ```')
  elseif node_type == 'struct_item' then
    local name = node:field('name')[1]
    table.insert(doc_lines, '/// Describe this struct.')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// # Fields')
    table.insert(doc_lines, '///')
    local body = node:field('body')[1]
    for field in body:iter_children() do
      local fname = field:field('name')[1]
      local ftype = field:field('type')[1]
      if fname and ftype then
        table.insert(
          doc_lines,
          string.format('/// - `%s` (`%s`) - Describe this field.', vim.treesitter.get_node_text(fname, bufnr), vim.treesitter.get_node_text(ftype, bufnr))
        )
      end
    end
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// # Examples')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// ```')
    table.insert(doc_lines, '/// use crate::...;')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, string.format('/// let s = %s { ... };', vim.treesitter.get_node_text(name, bufnr)))
    table.insert(doc_lines, '/// ```')
  elseif node_type == 'enum_item' then
    local name = node:field('name')[1]
    table.insert(doc_lines, '/// Describe this enum.')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// # Variants')
    table.insert(doc_lines, '///')
    local body = node:field('body')[1]
    for variant in body:iter_children() do
      if variant:type() == 'enum_variant' then
        local vname = variant:field('name')[1]
        if vname then
          table.insert(doc_lines, string.format('/// - `%s` - Describe this variant.', vim.treesitter.get_node_text(vname, bufnr)))
        end
      end
    end
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// # Examples')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, '/// ```')
    table.insert(doc_lines, '/// use crate::...;')
    table.insert(doc_lines, '///')
    table.insert(doc_lines, string.format('/// let kind = %s::...;', vim.treesitter.get_node_text(name, bufnr)))
    table.insert(doc_lines, '/// match kind {')
    table.insert(doc_lines, '///     // match arms')
    table.insert(doc_lines, '/// }')
    table.insert(doc_lines, '/// ```')
  end

  vim.api.nvim_buf_set_lines(bufnr, node:range(), node:range(), false, doc_lines)
end

return M
