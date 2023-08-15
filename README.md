# Mastermind Game

Mastermind is a classic code-breaking game where one player creates a secret code and the other player tries to guess it. This README provides an overview of the classes and their functionalities that make up the Mastermind game.

## Classes

### Player

The base class `Player` represents a player in the Mastermind game.

### HumanPlayer

`HumanPlayer` is a subclass of `Player` and represents a human player in the game. This class is responsible for handling user input for making guesses and scoring those guesses.

- `initialize(name, role)`: Constructor to initialize a human player with a name and role.
- `make_guess()`: Asks the player to input a guess for the secret code.
- `score_guess()`: Asks the player to input the number of black and white hits for computer guess.

### ComputerPlayer

`ComputerPlayer` is a subclass of `Player` and represents a computer player in the game. This class generates guesses and scores based on the provided algorithm.

- `initialize(role)`: Constructor to initialize a computer player with a role.
- `score_guess(guess)`: Scores a given guess against the secret code.
- `make_guess(last_guess_score)`: Generates a new guess based on the last guess's score.
- `score(guess, answer)`: Private method to calculate the black and white hit score between a guess and the secret code.

### MasterMindGame

The `MasterMindGame` class orchestrates the game between a human and a computer player.

- `initialize(user_name, user_role)`: Constructor to initialize the game with a user's name and role.
- `start_game()`: Starts the game based on the user's role and manages the game loop.

## How to Run

1. Run the game script by executing it in a Ruby environment.
2. Enter your name and role as a code maker (`cm`) or code breaker (`cb`).
3. If you are the code maker, choose a secret code (you do not need to enter this code in terminal).
4. Follow the prompts to make guesses and provide scores.
5. The game continues until one player breaks the code or the maximum number of guesses is reached.
