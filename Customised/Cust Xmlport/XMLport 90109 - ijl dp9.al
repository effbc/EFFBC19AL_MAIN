xmlport 90109 "ijl dp9"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable9)
        {
            tableelement("<integer>"; Item)
            {
                AutoSave = false;
                XmlName = 'Item';
                textelement(Textbox2)
                {
                }
                textelement(Posting_Date)
                {
                }
                textelement(Buy_from_Vendor_Name)
                {
                }
                textelement(Vendor_Invoice_No_)
                {
                }
                textelement(Vendor_Invoice_Date)
                {
                }
                textelement(ASSESSABLE_VALUE)
                {
                }
                textelement(SGST)
                {
                }
                textelement(CGST)
                {
                }
                textelement(IGST)
                {
                }
                textelement(SGST_RATE)
                {
                }
                textelement(CGST_RATE)
                {
                }
                textelement(IGST_RATE)
                {
                }
                textelement(TOTAL_INVOICED_AMT)
                {
                }
                textelement(DEPARTMENT)
                {
                }
                textelement(ACTUAL_DATE)
                {
                }
                textelement(GST_Jurisdiction_Type)
                {
                }
                textelement(GST_Registration_No_)
                {
                }
                textelement(GST_Vendor_Type)
                {
                }
                textelement(HSN_SAC_Code)
                {
                }
                textelement(HSN_Description)
                {
                }
                textelement(Vendor_state)
                {
                }
                textelement(SYSTEM_DATE)
                {
                }
                textelement(Unit_of_Measure)
                {
                }
                textelement(Quantity)
                {
                }
                textelement(ITC_Claim_Type)
                {
                }
                textelement(NilRated_Exempt_NonGST)
                {
                }
                textelement(Reverse_Charge)
                {
                }
                textelement(Import_type)
                {
                }
                textelement(Bill_of_Entry_Port_Code)
                {
                }
                textelement(Bill_of_Entry_No_)
                {
                }
                textelement(Bill_of_Entry_Date)
                {
                }
                textelement(voucher_no)
                {

                    trigger OnAfterAssignVariable();
                    begin
                        PurIH.Reset;
                        PurIH.SetFilter("No.", voucher_no);
                        EXDate := 19960520D;
                        daypart := 20;
                        monthpart := Date2DMY(Today, 2) - 1;
                        YearPart := Date2DMY(Today, 3);
                        Claimdate := DMY2Date(daypart, monthpart, YearPart);
                        if PurIH.FindFirst then begin
                            PurIH."Excise Claimed Date" := Claimdate;
                            PurIH.Modify;
                            // MESSAGE(FORMAT(Claimdate));
                            InvoicesCnt := InvoicesCnt + 1;

                        end
                    end;
                }
                textelement(Buy_from_Vendor_No_)
                {
                }
                textelement(GL_NO)
                {
                }
                textelement(GL_NAME)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        Message('Data Updation Completed!\Invoices Count: ' + Format(InvoicesCnt));
    end;

    var
        daypart: Integer;
        monthpart: Integer;
        YearPart: Integer;
        Claimdate: Date;
        EXDate: Date;
        InvoicesCnt: Integer;
        PurIH: Record "Purch. Inv. Header";
}

