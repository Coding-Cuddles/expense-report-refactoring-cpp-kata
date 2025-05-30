# Expense Report Refactoring C++ Kata

[![CI](https://github.com/Coding-Cuddles/expense-report-refactoring-cpp-kata/actions/workflows/main.yml/badge.svg)](https://github.com/Coding-Cuddles/expense-report-refactoring-cpp-kata/actions/workflows/main.yml)

## Overview

This kata complements [Clean Code: SOLID, Ep. 10 - Open-Closed Principle](https://cleancoders.com/episode/clean-code-episode-10).

In this exercise, you'll practice refactoring code to adhere to the Open-Closed
Principle (OCP). You'll be working with an expense report system that tracks
different types of expenses and prints a final report.

## Instructions

### Exercise 1

The `ExpenseReport` class in the `expense_report.h` file generates an expense
report. It iterates over a list of expenses, printing out a line for each
expense and totaling up the amounts.

The current implementation, however, is complex and hard to understand, and
it's not easy to modify or extend its behavior. It's your task to refactor this
code to make it cleaner and more maintainable, while ensuring that it still
correctly calculates and prints the report.

Make sure the program still behaves the same way after your refactoring.
There's a unit test suite in place that checks that on a very rudimentary level
by just looking at the output of the program.

### Exercise 2

When you're done with refactoring, test the quality of your refactoring by
implementing two additional scenarios:

1. Extend our system to handle two more types of expenses.

   1. **Transportation**. Surcharge: 5% of the expense amount.
   2. **Supplies**. Surcharge: No surcharge.

2. Add dynamic surcharge based on day of week.

   - For dinners on weekends, the surcharge is 15% of the expense amount.
   - For breakfasts on weekends, the surcharge is 10% of the expense amount.
   - On weekdays, the surcharges remain the same as before (10% for dinner
     and 5% for breakfast).

   You may need to add a `date` field to the `Expense` class to support this
   requirement. The date should be the date when the expense occurred.

   > [!NOTE]
   >
   > You can use the `std::tm` type in C++ to work with dates, and you
   > can determine if a date is a weekend by using the following function:
   >
   > ```cpp
   > #include <ctime>
   > #include <iomanip>
   > #include <iostream>
   > #include <string>
   >
   > bool is_weekend(const std::string& date_str)
   > {
   >     std::tm date{};
   >     std::istringstream ss(date_str);
   >     ss >> std::get_time(&date, "%Y-%m-%d");
   >     std::mktime(&date);
   >
   >     int day_of_week = date.tm_wday;
   >     // Check if it's Saturday (6) or Sunday (0)
   >     return day_of_week == 6 || day_of_week == 0;
   > }
   >
   > int main()
   > {
   >     std::string date_str = "2023-06-17";  // this is a Saturday
   >     std::cout << is_weekend(date_str) << std::endl;  // this should print: 1
   >     return 0;
   > }
   > ```

## Prerequisites

- A compatible C++ compiler that supports at least C++17
- [CMake](https://cmake.org)
- [GoogleTest](https://github.com/google/googletest)

## Usage

### Build

```console
make build
```

### Run tests

```console
make test
```
