_reduce = require 'lodash/reduce'
_isPlainObject = require 'lodash/isPlainObject'
_isEmpty = require 'lodash/isEmpty'

module.exports = (object) ->
  getDeepUndefinedKeys = (object, prefix = '') ->
    _reduce object, (missing, val, key) ->
      if val is undefined
        missing.concat prefix + key
      else if _isPlainObject val
        missing.concat getDeepUndefinedKeys val, key + '.'
      else
        missing
    , []

  missing = getDeepUndefinedKeys(object)
  unless _isEmpty missing
    throw new Error "missing values for: #{missing.join(', ')}"
