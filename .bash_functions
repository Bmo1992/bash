# User created functions

# Go up the number of directories specified in the argument
up () 
{
    for ((i=0; $i < $1; i++)); 
    do
        cd ..
    done
    # Print the new current working directory
    pwd    
}

# List the objects in the current working directory and return whether they're files or sub-directories
checkf ()
{
    for FILE in $(ls)
    do
        if [ -f $FILE ]; then
            echo "$FILE is a file"
        elif [ -d $FILE ]; then
            echo "$FILE is a directory"
        else
            echo "I've got no clue what $FILE is"
        fi
    done        
}

# Basic greeting on the time of day morning, afternoon, or evening
greeting ()
{
    HOUR=`date +%H | sed 's/^0//'`
    
    if [ "$HOUR" -ge 17 ]; then
        echo "Good evening $USER today is $(date)"
    elif [[ "$HOUR" -ge 11 && "$HOUR" -lt 17 ]]; then
        echo "Good afternoon $USER today is $(date)"
    else
        echo "Good morning $USER today is $(date)"
    fi

    unset HOUR
}


