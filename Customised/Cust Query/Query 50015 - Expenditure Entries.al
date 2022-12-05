query 50015 "Expenditure Entries"
{

    elements
    {
        dataitem(G_L_Account; "G/L Account")
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            dataitem(G_L_Entry; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = G_L_Account."No.";
                SqlJoinType = InnerJoin;
                column(Posting_Date; "Posting Date")
                {
                    ColumnFilter = Posting_Date = FILTER(20180401D);
                }
                column(Entry_No; "Entry No.")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Global_Dimension1_Code; "Global Dimension 1 Code")
                {
                }
                column(Debit_Amount; "Debit Amount")
                {
                    ColumnFilter = Debit_Amount = FILTER(> 0);
                }
                column(Description; Description)
                {
                }
                column(Dimension_Set_ID; "Dimension Set ID")
                {
                }
                dataitem(Dimension_Set_Entry; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = G_L_Entry."Dimension Set ID";
                    SqlJoinType = RightOuterJoin;
                    column(Dimension_Code; "Dimension Code")
                    {
                        ColumnFilter = Dimension_Code = CONST('EMPLOYEE CODES');
                    }
                    dataitem(Dimension_Value; "Dimension Value")
                    {
                        DataItemLink = Code = Dimension_Set_Entry."Dimension Value Code";
                        SqlJoinType = RightOuterJoin;
                        column(Emp_Name; Name)
                        {
                        }
                    }
                }
            }
        }
    }
}

