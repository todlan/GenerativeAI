"""A Number Guessing Game"""
import random;


obj Game {
    has won: bool = False;

    def play;
}


obj GuessTheNumberGame (Game) {
    has correct_number: int = random.randint(1, 10);

    def init;
    override def play;
    def process_guess(guess: int);
}

# Run the game
 with entry {
    game = GuessTheNumberGame();
    game.play();
}
impl Game.play{
    raise NotImplementedError("Subclasses must implement this method.") ;
}


impl GuessTheNumberGame.init{
    self.correct_number = random.randint(1, 10);
}


impl GuessTheNumberGame.play{
    has attempts:int;
    self.attempts = int(input("Enter The Number of Attempts To Guess: "));
    while self.attempts > 0 {
        guess = input("Guess a number between 1 and 10: ");
        if guess.isdigit() {
            self.process_guess(int(guess));
        } else {
            print("That's not a valid number! Try again.");
        }
    }
    if not self.won {
        print("Sorry, you didn't guess the number. Better luck next time!");
    }
}


impl GuessTheNumberGame.process_guess(guess: int) {
    if guess > self.correct_number {
        print("Too high!");
        self.attempts -= 1;
    } elif guess < self.correct_number {
        print("Too low!");
        self.attempts -= 1;
        print(f"You have {self.attempts} attempts left.");
        if self.attempts == 0 {
            prompt = input("Do You Wish to Continue Y/N: ");
            if "Y" in prompt or "y" in prompt{
                self.attempts = int(input("Enter The Number of Attempts To Guess: "));
                print(f"You have {self.attempts} attempts to Try Again."); 
            }elif "N" in prompt or "n" in prompt{
                return;
            }

        }
    } else {
        print("Congratulations! You guessed correctly.");
        self.won = True;
        self.attempts = 0;
        return;
    }
   
}