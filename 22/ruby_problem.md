On an Apple Silicon M1 with macOS Big Sur 11.1

ruby compiled by Apple is correct, but other rubys are incorrect and inconsistent.

Here is an Advent of Code puzzle that prints the correct result with the system ruby (2.6.3) included in macOS 11.1. With any other ruby, I get an incorrect answer and the incorrect answer is different each time(!)

The code has some recursive object creation. A `Game` object creates a child `Game` object by calling `Game.new(....).play_part2()`, recursively.

On a successful run with Apple's ruby, it creates more than 13000 `Game` objects and prints a correct puzzle answer of `33441`.

On an unsuccessful run with Homebrew or `rbenv` rubys, it creates anywhere from just 4 `Game` objects to over 15000 `Game` objects, and gives various answers.


## Correct:

    % /usr/bin/ruby -v      
    ruby 2.6.3p62 (2019-04-16 revision 67580) [universal.arm64e-darwin20]
    % /usr/bin/ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 33441


## Incorrect:
homebrew cask (precompiled) ruby for `arm64`

    % /opt/homebrew/opt/ruby/bin/ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
    % /opt/homebrew/opt/ruby/bin/ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 31425
    % /opt/homebrew/opt/ruby/bin/ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 32632

## Incorrect:
homebrew cask (precompiled) ruby for `x86_64` (runs with Rosetta2)

    % /usr/local/opt/ruby/bin/ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
    % /usr/local/opt/ruby/bin/ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 34692
    % /usr/local/opt/ruby/bin/ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 32133

## Incorrect:
I also get incorrect results with 2.7.2 and 3.0.0 locally built via `rbenv install ...`.

    % ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
    % ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 34333
    % ruby ruby_problem.rb
    Day 22 part 2: player 1 wins, with 31804  
    


Code that exercises the behavior is available here:
https://github.com/samwich/advent_of_code_2020/tree/main/22

you can run `ruby ./ruby_problem.rb`

This is probably unrelated, but I see that the built-in ruby which gives the correct answer is compiled to the `arm64e` target, which enables some kind of pointer authentication. The homebrew and locally compiled rubys target `arm64`.
