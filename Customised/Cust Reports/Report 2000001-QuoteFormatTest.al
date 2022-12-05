report 2000001 "Quote Format Test"
{
    DefaultLayout = RDLC;
    RDLCLayout = './QuoteFormatTest.rdl';
    Caption = 'Quote Format';
    EnableExternalImages = true;
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(Quote));
            RequestFilterFields = "No.";
            column(SNoCaption; SNoCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(UnitCaption; UnitCaptionLbl)
            {
            }
            column(RateCaption; RateCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(CorporateIdentityNoCaption; CorporateIdentityNoCaptionLbl)
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(CustorContactNameGVar; CustorContactNameGVar)
            {
            }
            column(CustorContactCityGVar; CustorContactCityGVar)
            {
            }
            column(CustoPrimaryContactGVar; CustoPrimaryContactGVar)
            {
            }
            column(CustorContactMailGVar; CustorContactMailGVar)
            {
            }
            column(CustorContactAddress1GVar; CustorContactAddress1GVar)
            {
            }
            column(CustorContactAddress2GVar; CustorContactAddress2GVar)
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(Customer_City; Customer.City)
            {
            }
            column(CustomerEMail; Customer."E-Mail")
            {
            }
            column(CustomerPrimaryContactNo; Customer."Primary Contact No.")
            {
            }
            column(Customer_Contact; Customer.Contact)
            {
            }
            column(SubBudgetaryPropoCaption; SubBudgetaryPropoCaptionLbl)
            {
            }
            column(RegardingCaption; RegardingCaptionLbl)
            {
            }
            column(WithReferenceCaption; WithReferenceCaptionLbl)
            {
            }
            column(foryourconsiderationCaption; foryourconsiderationCaptionLbl)
            {
            }
            column(WORKDATE; WORKDATE)
            {
            }
            column(RefCaption; RefCaptionLbl)
            {
            }
            column(NoofArchivedVersions_SalesHeader; "Sales Header"."No. of Archived Versions")
            {
            }
            column(PaymentTerms_Code; PaymentTerms.Code)
            {
            }
            column(PaymentTerm_Description; PaymentTerms.Description)
            {
            }
            column(CustorContactTerrotoryGvar; CustorContactTerrotoryGvar)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(NoText_1; NoText[1])
            {
            }
            column(RegName; RegName)
            {
            }
            column(RegJobTitle; RegJobTitle)
            {
            }
            column(RegEmail; RegEmail)
            {
            }
            column(RegPhone; RegPhone)
            {
            }
            column(Remarks_SalesHeader; "Sales Header".Remarks)
            {
            }
            column(YourReference_SalesHeader; "Sales Header"."Your Reference")
            {
            }
            column(SalespersonPurchaserGRec_SalesPersonSignature; SalespersonPurchaserGRec."Sales Person Signature")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Description2_SalesLine; "Sales Line"."Description 2")
                {
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }
                column(UnitofMeasureCode_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(DocumentType_SalesLine; "Sales Line"."Document Type")
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(Sno; Sno)
                {
                }
                column(TotAmtGVar; TotAmtGVar)
                {
                }
                dataitem("Extended Text Line"; "Extended Text Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = WHERE("Table Name" = FILTER(Item));
                    column(TextNo_ExtendedTextLine; "Extended Text Line"."Text No.")
                    {
                    }
                    column(LineNo_ExtendedTextLine; "Extended Text Line"."Line No.")
                    {
                    }
                    column(No_ExtendedTextLine; "Extended Text Line"."No.")
                    {
                    }
                    column(Text_ExtendedTextLine; "Extended Text Line".Text)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Sno += 1;
                    IF LineNoGvar <> "Sales Line"."Line No." THEN BEGIN
                        TotAmtGVar += "Sales Line".Quantity * "Sales Line"."Unit Price";
                        LineNoGvar := "Sales Line"."Line No.";
                    END;

                    RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, TotAmtGVar, "Sales Header"."Currency Code");
                end;

                trigger OnPreDataItem()
                begin
                    Sno := 0;
                    LineNoGvar := 0;
                    CLEAR(TotAmtGVar);
                end;
            }
            dataitem("Sales Quote Specification"; "Sales Quote Specification")
            {
                DataItemLink = "Sales Quote No." = FIELD("No.");
                column(No_SalesQuoteSpecification; "No.")
                {
                }
                column(Description_SalesQuoteSpecification; Description)
                {
                }
                column(SalesQuoteNo_SalesQuoteSpecification; "Sales Quote No.")
                {
                }
                column(LookupCode_SalesQuoteSpecification; "Lookup Code")
                {
                }
                column(LookupTypeID_SalesQuoteSpecification; "Lookup Type ID")
                {
                }
                column(LookupTypeName_SalesQuoteSpecification; "Lookup Type Name")
                {
                }
                column(TermsLookUp_SalesQuoteSpecification; "Terms LookUp")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                CustomerLRec: Record Customer;
                ContactLRec: Record Contact;
            begin
                CLEAR(CustorContactNameGVar);
                CLEAR(CustorContactCityGVar);
                CLEAR(CustoPrimaryContactGVar);
                CLEAR(CustorContactMailGVar);
                CLEAR(CustorContactTerrotoryGvar);
                CLEAR(CustorContactAddress1GVar);
                CLEAR(CustorContactAddress2GVar);
                Customer.GET("Sales Header"."Sell-to Customer No.");
                CLEAR(RegName);
                CLEAR(RegJobTitle);
                CLEAR(RegEmail);
                CLEAR(RegPhone);
                //SalesPersonID := '';
                //SalesPersonID := 'File:\\storage\\SHARE\\DEPT_Common\\DT\\Vishnu Priya\\Sales Managers Pics\\' + "Sales Header"."Salesperson Code" + '.png';
                CustomerLRec.RESET;
                SalespersonPurchaserGRec.RESET;
                IF TypeGVar = TypeGVar::Customer THEN BEGIN
                    IF CustomerLRec.GET(CustorContactGVar) THEN BEGIN
                        CustorContactNameGVar := CustomerLRec.Name;
                        CustorContactCityGVar := CustomerLRec.City;
                        CustoPrimaryContactGVar := CustomerLRec."Phone No.";
                        CustorContactMailGVar := CustomerLRec."E-Mail";
                        CustorContactAddress1GVar := CustomerLRec.Address;
                        CustorContactAddress2GVar := CustomerLRec."Address 2";
                        CustorContactTerrotoryGvar := CustomerLRec."Territory Code";
                        IF CustomerLRec."Payment Terms Code" <> '' THEN
                            PaymentTerms.GET(CustomerLRec."Payment Terms Code");
                        IF CustomerLRec."Salesperson Code" <> '' THEN BEGIN
                            IF SalespersonPurchaserGRec.GET(CustomerLRec."Salesperson Code") THEN BEGIN
                                RegName := SalespersonPurchaserGRec.Name;
                                RegJobTitle := SalespersonPurchaserGRec."Job Title";
                                RegEmail := SalespersonPurchaserGRec."E-Mail";
                                RegPhone := SalespersonPurchaserGRec."Phone No.";
                                SalespersonPurchaserGRec.CALCFIELDS("Sales Person Signature");
                            END;
                        END;
                    END;
                END ELSE BEGIN
                    IF ContactLRec.GET(CustorContactGVar) THEN BEGIN
                        CustorContactNameGVar := ContactLRec.Name;
                        CustorContactCityGVar := ContactLRec.City;
                        CustoPrimaryContactGVar := ContactLRec."Phone No.";
                        CustorContactMailGVar := ContactLRec."E-Mail";
                        CustorContactAddress1GVar := ContactLRec.Address;
                        CustorContactAddress2GVar := ContactLRec."Address 2";
                        CustorContactTerrotoryGvar := ContactLRec."Territory Code";
                        IF ContactLRec."Salesperson Code" <> '' THEN BEGIN
                            IF SalespersonPurchaserGRec.GET(ContactLRec."Salesperson Code") THEN BEGIN
                                RegName := SalespersonPurchaserGRec.Name;
                                RegJobTitle := SalespersonPurchaserGRec."Job Title";
                                RegEmail := SalespersonPurchaserGRec."E-Mail";
                                RegPhone := SalespersonPurchaserGRec."Phone No.";
                            END;
                        END;
                    END;
                END;
            end;
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        SNoCaptionLbl: Label 'S.No.';
        DescriptionCaptionLbl: Label 'Description';
        QtyCaptionLbl: Label 'Qty.';
        UnitCaptionLbl: Label 'Unit';
        RateCaptionLbl: Label 'Rate(Rs.)';
        AmountCaptionLbl: Label 'Amount(Rs.)';
        TotalCaptionLbl: Label 'Total';
        Sno: Integer;
        CorporateIdentityNoCaptionLbl: Label 'Corporate Identity  No:';
        PageCaptionLbl: Label 'Page';
        Customer: Record Customer;
        SubBudgetaryPropoCaptionLbl: Label 'Sub:';
        RegardingCaptionLbl: Label 'Regarding.';
        WithReferenceCaptionLbl: Label 'With reference to the above cited subject, we are here with furnishing our budgetary quote for the following items for your kind consideration';
        foryourconsiderationCaptionLbl: Label 'for your kind consideration.';
        RefCaptionLbl: Label 'Ref:';
        CustorContactGVar: Code[20];
        TypeGVar: Option Customer,Contact;
        CustorContactNameGVar: Text[50];
        CustorContactCityGVar: Text[30];
        PaymentTerms: Record "Payment Terms";
        CustoPrimaryContactGVar: Text[250];
        CustorContactMailGVar: Text[250];
        CustorContactTerrotoryGvar: Code[20];
        TotAmtGVar: Decimal;
        LineNoGvar: Integer;
        CompanyInformation: Record "Company Information";
        RepCheck: Report 1401;
        NoText: array[2] of Text;
        CustorContactAddress1GVar: Text[250];
        CustorContactAddress2GVar: Text[250];
        CustomerGRec: Record Customer;
        SalespersonPurchaserGRec: Record "Salesperson/Purchaser";
        RegName: Text[250];
        RegJobTitle: Text[250];
        RegEmail: Text[250];
        RegPhone: Text[250];
        ContactGRec: Record Contact;
        //SalesPErsonImg: Binary[100];
        SalesPersonID: Text[250];

    procedure SetValues(TypePar: Option Customer,Contact; CustorContactPar: Code[20])
    begin
        CustorContactGVar := CustorContactPar;
        TypeGVar := TypePar;
    end;
}

