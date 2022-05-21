#include <bits/stdc++.h>
using namespace std;

//Declaring user class (an OOP feature) to store details of user
class User    
{
    //All data is declared privately so that it is not modified by unauthorised functions/entities
    //An example of ABSTRACTION
    string username;
    string pass;
    float wallet;
    public: 
    //Initialising each username with passed arguments and a default money of 100. 
    //Demonstrates Constructor with DEFAULT ARGUMENTS
    User(string u, string p, float i_bal)
    {
        username=u;
        pass=p;
        wallet=i_bal;
    }
    User(string u, string p)
    {
        username=u;
        pass=p;
        wallet=100;
    }
    //returns current bank balance
    int check_bal()
    {
        return wallet;
    }
    //checks if the username matches to entered username
    bool check_username(string u)
    {
        return !strcmp(u.c_str(),username.c_str());
    }
    //checks if the password matches to entered password
    bool check_pass(string p)
    {
        return !strcmp(p.c_str(),pass.c_str());
    }
    //function to add money to bank account
    void deposit(int amt)
    {
        wallet+=amt;
    }
    //function to take money out of bank account
    bool withdraw(int amt)
    {
        if(amt<=wallet)
        {wallet-=amt; return true;}
        else
        return false;
    }
};
//All data of users and functions related to user are put under one class
//Demonstrates ENCAPSULATION

//Other function declaration
void open_acc();
void login();
void show_ledger();

//A vector containing all user objects(an OOP feature) 
vector <User> database;
int main() 
{
    int option;
    //Initial interface to open/login into your account.
    do
    {
        cout<<"\nSelect One Option Below ";
        cout<<"\n\t1 Open an Account\n\t2.Login to your account\n\t3.Quit";
        cout<<"\nEnter your choice: ";
        cin>>option;
        switch(option)
        {
        case 1: open_acc();
        break;
        case 2: login();
        break;
        case 3:
        break;
        default:
        cout<<"\nEnter correct choice( a value between 1-3)";
        exit(0);
        }
    }while(option!=3);


    return 0;
    }

//function for registering a new user
void open_acc()
{
    string u,p;
    int ch;
    cout<<"\nEnter Username:";
    cin>>u;
    cout<<"\nEnter Password:";
    cin>>p;
    int i=0;
    //Checks if username is already taken
    for(User t : database)
    {
        if(t.check_username(u)) {cout<<"\nUsername already exsists. Try again with a different username"; break;}
    }
    if(i>=database.size())
    {
        cout<<"\nDo you want to deposit an initial amount?(Bank gives a bonus 100 on opening new account)\n1.Yes\n2.No";
        cin>>ch;
        //Here if user gives an initial amount that is given as argument otherwise it is skipped
        //An example of constructor overloading
        //Demonstrates POLYMORPHISM
        if(ch==1)
        {
            cout<<"Enter Amount"; 
            int amount;
            cin>>amount;
            User tmp(u,p,amount+100);
            database.push_back(tmp);
        }
        else if(ch==2)
        {
            User tmp(u,p);
            database.push_back(tmp);
        }
        else cout<<"Invalid input. Try again!";
    }
}
//Function to make sure only authorised person can withdraw or deposit money
void login()
{
    string u,p;
    cout<<"\nEnter Username:";
    cin>>u;
    cout<<"\nEnter Password:";
    cin>>p;
    int flag = 0,i=0;
    //loop to find entered username and pass matching with data in the database
    for(;i<database.size();i++)
    {
        if(database[i].check_username(u))
        {
            if(database[i].check_pass(p))
            {
                flag=2; break;
            }
            else
            {
                flag=1; break;
            }
        }
    }
    if(flag==0) {cout<<"\nNo such user found.Try Again with a different username";}
    if(flag==1) {cout<<"\nWrong password. Enter the correct password";}
    //After successful login i.e. matching password and username
    if(flag==2)
    {
        //Code to withdraw or deposit money or to check balance
        int option2;
        do
        {
            cout<<"\n\tLoginSuccessful\n\t\t1.Deposit\n\t\t2.Withdraw\n\t\t3.Check balance\n\t\t4.Logout\nEnter your choice:";
            cin>>option2;
            float amount;
            switch(option2)
            {
            case 1:
                cout<<"\nEnter amount";
                cin>>amount;
                database[i].deposit(amount);
                cout<<"\nAmount deposited.";
                break;
            case 2: 
                cout<<"\nEnter amount";
                cin>>amount;
                if(!database[i].withdraw(amount))
                cout<<"\nTransaction failed. Insufficient balance";
                else
                cout<<"\nAmount withdrawn";
                break;
            case 3:
                cout<<"\nCurrent account balance is: ";
                cout<<database[i].check_bal();
                break;
            case 4:
            break;
            default:
            cout<<"\nEnter correct choice( a value between 1-4)";
            exit(0);
            }
        }while(option2!=4);
    }
}
