# basically copied from https://gist.github.com/seanchas116/6315859
class Tutor < Parslet::Parser
  rule(:lparen)     { str('(') >> space? }
  rule(:rparen)     { str(')') >> space? }
  
  rule(:space)      { match('\s').repeat(1) }
  rule(:space?)     { space.maybe }

  rule(:integer)    { match('[0-9]').repeat(1).as(:int) >> space? }
  rule(:operator)   { match('[+*]').as(:op) >> space? }

  
  # grammar
  rule(:factor)      { integer | lparen >> expression.as(:expression) >> rparen }
  rule(:expression)  { factor >> (operator >> factor).repeat(0) }
  
  root(:expression)
end