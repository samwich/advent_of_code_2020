# basically copied from https://gist.github.com/seanchas116/6315859
class Tutor < Parslet::Parser
  rule(:lparen)     { str('(') >> space? }
  rule(:rparen)     { str(')') >> space? }
  
  rule(:space)      { match('\s').repeat(1) }
  rule(:space?)     { space.maybe }

  rule(:integer)    { match('[0-9]').repeat(1).as(:int) >> space? }
  rule(:operator)   { match('[+*]').as(:op) >> space? }

  rule(:parens)     { lparen >> expression.as(:expression) >> rparen }
  rule(:factor)     { parens | integer }
  rule(:expression) { factor >> ((operator >> factor).repeat(0)).maybe }

  # rule(:expression) { expression >> '*' >> term || term }
  # rule(:term)       { term >> '+' >> atom || atom }
  # rule(:atom)       { integer || lparen >> expr >> rparen }
  
  # rule(:expr) { expr >> '+' >> term || expr >> '-' >> term || term }
  # rule(:term) { term >> '*' >> atom || term >> '/' >> atom || atom }
  # rule(:atom) { integer || lparen >> expr >> rparen }

  # taken from guido van rossums beuilding a PEG series:
  # statement: assignment | expr | if_statement
  # expr: expr '+' term | expr '-' term | term
  # term: term '*' atom | term '/' atom | atom
  # atom: NAME | NUMBER | '(' expr ')'
  # assignment: target '=' expr
  # target: NAME
  # if_statement: 'if' expr ':' statement
  
  
  
  
  root(:expression)
end

IntLit = Struct.new(:int) do
  def eval
    int.to_i
  end
end

Calculation = Struct.new(:left, :operator, :right) do
  def eval
    case operator
    when '+'
      left.eval + right.eval
    when '*'
      left.eval * right.eval
    end
  end
end

class Transformer < Parslet::Transform
  rule(:int => simple(:int))        { IntLit.new(int) }
  rule(:left => simple(:left),
       :right => simple(:right),
       :op => simple(:op))          { Calculation.new(left, op, right)}
end