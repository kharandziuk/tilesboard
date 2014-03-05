
COMPONENTS = '../components'

fromBower = (dir, name) ->
  name = name or dir
  return "#{COMPONENTS}/#{dir}/#{name}"

require.config()

require([], ()-> alert 'test')
