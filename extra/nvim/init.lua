local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.set')
require('user.plugins')
load('user.remap')

