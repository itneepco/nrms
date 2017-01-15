module RiskRegistersHelper
    def format_target_date(date)
        date.strftime("%d-%m-%Y")
    end
    
    def append_category_names(categories)
        category_array = []
        categories.each do |category|
            category_array.push(category.name)
        end
        category_array.join(", ")
    end
    
    def append_mitigator_emails(mitigators)
        mitigator_array = []
        mitigators.each do |mitigator|
            mitigator_array.push(mitigator.email)
        end
        mitigator_array.join(", ")
    end
    
    def two_digit(value)
        if value < 9
            '0' + value.to_s
        else
            value.to_s
        end
    end
    
    def get_year_yy
        Date.today.strftime("%Y").last(2)
    end
    
    def increment_by_one_s(value)
        (value + 1).to_s
    end
end
