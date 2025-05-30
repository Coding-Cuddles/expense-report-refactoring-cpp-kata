#include <iomanip>
#include <iostream>
#include <sstream>
#include <vector>
#include <string>

class ReportPrinter {
public:
    virtual ~ReportPrinter() = default;

    virtual void print(const std::string& text) = 0;
};

enum ExpenseType { DINNER, BREAKFAST, LODGING };

class Expense {
public:
    Expense(ExpenseType type, int amount) : type(type), amount(amount) {}

    ExpenseType type;
    int         amount;
};

class ExpenseReport {
private:
    std::vector<Expense> expenses;

public:
    void add_expense(const Expense& expense) { expenses.push_back(expense); }

    void print_report(ReportPrinter& printer) const
    {
        printer.print("Expense Report");
        printer.print("--------------");

        double total      = 0;
        double meal_total = 0;
        for (const Expense& expense : expenses) {
            double      surcharge = 0;
            std::string name;

            if (expense.type == DINNER) {
                surcharge = expense.amount * 0.10;
                name      = "Dinner";
            }
            else if (expense.type == BREAKFAST) {
                surcharge = expense.amount * 0.05;
                name      = "Breakfast";
            }
            else if (expense.type == LODGING) {
                surcharge = expense.amount * 0.15;
                name      = "Lodging";
            }
            else {
                name = "Other";
            }

            total += expense.amount + surcharge;
            if (expense.type == DINNER || expense.type == BREAKFAST) {
                meal_total += expense.amount + surcharge;
            }

            std::string meal_over_expenses_marker =
                ((expense.type == DINNER && expense.amount > 5000) ||
                 (expense.type == BREAKFAST && expense.amount > 1000))
                    ? "X"
                    : "";

            std::ostringstream oss;
            oss << std::fixed << std::setprecision(2) << name << "\t" << expense.amount / 100.0
                << "\t" << meal_over_expenses_marker;
            printer.print(oss.str());
        }

        printer.print("--------------");
        std::ostringstream oss;
        oss << "Meal Total: " << std::fixed << std::setprecision(2) << meal_total / 100.0 << "\n";
        oss << "Total: " << std::fixed << std::setprecision(2) << total / 100.0;
        printer.print(oss.str());
    }
};
