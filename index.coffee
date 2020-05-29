import * as _ from 'lodash-es'

export default (object) ->
  getDeepUndefinedKeys = (object, prefix = '') ->
    _.reduce object, (missing, val, key) ->
      if val is undefined
        missing.concat prefix + key
      else if _.isPlainObject val
        missing.concat getDeepUndefinedKeys val, key + '.'
      else
        missing
    , []

  missing = getDeepUndefinedKeys(object)
  unless _.isEmpty missing
    throw new Error "missing values for: #{missing.join(', ')}"
