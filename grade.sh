CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
# 1. Cloning the repository of the student submission
git clone $1 student-submission
echo 'Finished cloning'
# cd student-submission

# 2. Checking if the student code has the correct  file
set -e
# files= `find student-submission -name "*.java"`
for file in student-submission
do
    if [ -f $file ] &&  [$file == *ListExamples.java* ];
    then
        echo 'Correct file found in submission: "ListExamples.java"'
        found = true
        # exit 0
    else
        continue
    fi
done
if [[ $found == false ]];
then
    echo 'File not found in submission: "ListExamples.java"'
    exit 1
fi

# 3. Getting student code and tester file into the same directory

cp TestListExamples.java code-and-tests

cd student-submission
cp ListExamples.java code-and-tests

# 4. Compiling the tests and student code
set +e # Turning off set-e because we want to continue even if compilation fails

# Copying the JUnit library into the directory because it wasn't working otherwise
cp -r lib code-and-tests 

cd code-and-tests

# Compiling and redirecting standard errors to compile-errors.txt
javac -cp $CPATH *.java 2> compile-errors.txt
cat compile-errors.txt # Printing the errors (if any)

# 5. Running the tester file
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > out.txt 2>&1
cat out.txt # Printing results of the running the tester







