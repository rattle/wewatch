CONSUMER_KEY='8M87tYKRudLAwgMV4bC4A'
CONSUMER_SECRET='GvJUM3tOuafIRie5AmigpX9g97o06n68k1CxUCc39kc'


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '8M87tYKRudLAwgMV4bC4A', 'GvJUM3tOuafIRie5AmigpX9g97o06n68k1CxUCc39kc'
end
