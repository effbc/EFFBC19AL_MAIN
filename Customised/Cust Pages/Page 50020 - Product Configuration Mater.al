page 50020 "Product Configuration Mater"
{
    SourceTable = "Product Configurations Master";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152001)
            {
                ShowCaption = false;
                field(Configuration; Rec.Configuration)
                {
                    ApplicationArea = All;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

