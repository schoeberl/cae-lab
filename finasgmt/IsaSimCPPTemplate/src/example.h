//Example header file
#pragma once

class Example {
private:
    int ex;

public:
    //disallow default construction example
    Example() = delete;

    //disallow copy example
    Example(const Example &) = delete;

    //Example constructor
    Example(int ex);

    //Example methods with example doc
    /**
     * @brief Getter function for the example attribute
     * @returns the example attribute
     */
    int getEx() const;

    /**
     * @brief Setter function for the example attribute
     * @param newEx the new value that will be given to the attribute
     */
    void setEx(int newEx);
};