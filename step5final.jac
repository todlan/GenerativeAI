"""A Number Guessing Game"""

import random;

walker GuessGame {
    
    

    can start with `root entry;
    can process_guess with turn entry;
}

node turn {
    has correct_number: int = random.randint(1, 10);
}

# Will run when in CLI mode (not in cloud)
 with entry:__main__ {
    
    root spawn GuessGame();
}

impl GuessGame.start {
    if not [root --> (`?turn)] {
        next = root ++> turn(random.randint(1, 10));
    } else {
        next = [root --> (`?turn)];
    }
    visit next;
}

impl GuessGame.process_guess {
    has attempts: int;
    has guess: int;
    self.attempts = int(input("Enter the number of attempts To Try: "));
    while self.attempts > 0{
        self.guess = int(input("Guess a Number Between 1 and 10: "));
      
            if self.guess > here.correct_number {
                print("Too high!");
                here ++> turn(here.correct_number);
            } elif self.guess < here.correct_number {
                print("Too low!");
                here ++> turn(here.correct_number);
            } else {
                print("Congratulations! You guessed correctly.");
                disengage;
                return;
            }
        
        self.attempts -= 1;
        print(f"You have {self.attempts} attempts left.");

        if self.attempts == 0{
            ans = input("Do You Wish to Continue (Y/N): ");
            if "Y" in ans or "y" in ans{
                self.attempts = int(input("Enter The Number of Trys to attempt Again: "));
                print(f"You have {self.attempts} attempts to Try Again!");
            }elif "N" in ans or "n" in ans {
                print("To Bad to See You Go, Better Luck Next Time");
            }
        }
    }
     print("Sorry, you didn't guess the number. Better luck next time!");

}