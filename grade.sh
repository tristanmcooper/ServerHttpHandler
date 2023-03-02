CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
# 1. Cloning the repository of the student submission
git clone $1 student-submission
echo 'Finished cloning'

# 2. Checking if the student code has the correct  file
set -e
# files= `find student-submission -name "*.java"`
cd student-submission

if [[ -e 'ListExamples.java' ]]
then
    echo 'Correct file found in submission: "ListExamples.java"'
else
    echo 'File not found in submission: "ListExamples.java"'
    exit
fi

# 3. Copying the student code to the working directory with the tester file and lib
cp ListExamples.java ..

cd .. # Returning to code-and-tests directory in order to run JUnit

# 4. Compiling the tests and student code
set +e # Turning off set-e because we want to continue even if compilation fails

# Compiling and redirecting standard errors to compile-errors.txt
javac -cp $CPATH *.java 2> compile-errors.txt
if [ $? -eq 0 ]; then
    echo "Compilation successful"
else
    echo "Compilation failed"
    exit 1
fi
cat compile-errors.txt # Printing the errors (if any)

# 5. Running the tester file
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > out.txt 2>&1
if [ $? -eq 0 ]; then
    echo "Tests passed"
else
    echo "Tests failed. Statistics below."
    echo `grep "Tests run:" out.txt`
fi
cat out.txt # Printing results of the running the tester








