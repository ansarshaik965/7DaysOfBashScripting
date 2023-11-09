#!/bin/bash

function check_user()
{
	check="$(compgen -u | grep "$User" | awk '$User {print "true"}')"
};

function create_user()
{
	echo "Enter New User Name:"
	read User
	check_user $User
	if [[ $check = "true" ]]
	then
		echo "User Name $User already exist, Please Choose Different User Name!"

	else
		echo "Enter The Password For $User :"
		read pass
		sudo useradd -m -p $pass $User && echo "User Account $User Added Successfully"
	
	fi
};

function delete_user()
{
	echo "Enter User Name to Delete:"
        read User
        check_user $User
        if [[ $check = "true" ]]
        then
                sudo userdel $User
		userdel $User
		echo "User Account $User Deleted Successfully"

        else
                echo "User Name $User Does not Exist, Please Enter a Valid User Name!"

        fi
};

function reset_password()
{
        echo "Enter The User Name to Reset Password:" 
        read User
        check_user $User
        if [[ $check = "true" ]]
        then
		echo "Enter The New Password for $User"
                sudo passwd $User
                echo "Password for  $User Changed Successfully"

        else
                echo "User Name $User Does not Exist, Please Enter a Valid User Name!"

        fi
};

function list_users()
{
	echo "User Accounts on The System"

	awk -F: '{print NR, $1,"( UID: ",$3,")"}' /etc/passwd
};
	

if [ -z $1 ] || [ $1 = -h ] || [ $1 = --help ]
then
	echo "Usage: ./user_management.sh [OPTIONS]
	      Options:
	      -c, --create     Create a new user account.
	      -d, --delete     Delete an existing user account.
	      -r, --reset      Reset password for an existing user account.
	      -l, --list       List all user accounts on the system.
	      -h, --help       Display this help and exit."
elif [ $1 = -c ] || [ $1 = --create ]
then
	create_user 
elif [ $1 = -d ] || [ $1 = --delete ]
then
	delete_user
	
elif [ $1 = -r ] || [ $1 = --reset ]
then
	reset_password
else [ $1 = -l ] || [ $1 = --list ]
	list_users	
fi
