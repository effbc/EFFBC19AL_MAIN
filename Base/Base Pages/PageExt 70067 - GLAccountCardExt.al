pageextension 70067 GLAccountCardExt extends "G/L Account Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Cash Account"; Rec."Cash Account")
            {
                ApplicationArea = All;
            }
            field("TDS Account"; Rec."TDS Account")
            {
                ApplicationArea = All;
            }
            field("Work Tax Account"; Rec."Work Tax Account")
            {
                ApplicationArea = All;
            }
        }
        addafter("Default Deferral Template Code")
        {
            group("P&L Setups")
            {
                Caption = 'P&L Setups';
                field("Reflect in P&L"; Rec."Reflect in P&L")
                {
                    Caption = 'Reflect in P&L*';
                    Editable = PL_EDITABLE;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Reflect in P&L" = Rec."Reflect in P&L"::Yes) THEN BEGIN
                            Rec."PL Head" := TRUE;
                            Rec.Reflected_in_pl_datetime := CURRENTDATETIME;
                            Rec.Reflected_in_pl_userid := USERID;
                            Rec."Reflect in P&L" := Rec."Reflect in P&L"::Yes;
                            Rec.MODIFY;
                        END;
                        IF (Rec."Reflect in P&L" = Rec."Reflect in P&L"::No) THEN BEGIN
                            Rec."PL Head" := FALSE;
                            Rec.Reflected_in_pl_datetime := CURRENTDATETIME;
                            Rec.Reflected_in_pl_userid := USERID;
                            Rec."Reflect in P&L" := Rec."Reflect in P&L"::No;
                            Rec.MODIFY;
                        END;
                    end;
                }
                field("PL Income Type"; "PL income Type")
                {
                    Caption = 'P&L Income Type*';
                    Editable = PL_EDITABLE;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CASE "PL income Type" OF
                            "PL income Type"::Branch:
                                Rec."PL IncomeType" := 'Branch';
                            "PL income Type"::"Direct Incomes":
                                Rec."PL IncomeType" := 'Direct Incomes';
                            "PL income Type"::"Duties & Taxes":
                                Rec."PL IncomeType" := 'Duties & Taxes';
                            "PL income Type"::Expenditure:
                                Rec."PL IncomeType" := 'Expenditure';
                            "PL income Type"::"Fixed Assets":
                                Rec."PL IncomeType" := 'Fixed Assets';
                            "PL income Type"::"Indirect Incomes":
                                Rec."PL IncomeType" := 'Indirect Incomes';
                            "PL income Type"::Stock:
                                Rec."PL IncomeType" := 'Stock';
                            ELSE
                                Rec."PL IncomeType" := FORMAT("PL income Type"::" ");
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("P&L Income Type Summary"; "P&L Income Type Summary")
                {
                    Caption = 'P&L Income Type Summary*';
                    Editable = PL_EDITABLE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CASE "P&L Income Type Summary" OF
                            "P&L Income Type Summary"::Stock:
                                Rec."PL Income Type Summary" := 'Stock';
                            "P&L Income Type Summary"::"Total Expenditure":
                                Rec."PL Income Type Summary" := 'Total Expenditure';
                            "P&L Income Type Summary"::"Total Income":
                                Rec."PL Income Type Summary" := 'Total Income';
                            ELSE
                                Rec."PL Income Type Summary" := FORMAT("P&L Income Type Summary"::" ");
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("P&L Income Expenditure"; "P&L Income Expenditure")
                {
                    Caption = 'P&L Income Expenditure*';
                    Editable = PL_EDITABLE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CASE "P&L Income Expenditure" OF
                            "P&L Income Expenditure"::Expenditure:
                                Rec."PL Income Expenditure" := 'Expenditure';
                            "P&L Income Expenditure"::Income:
                                Rec."PL Income Expenditure" := 'Income';
                            ELSE
                                Rec."PL Income Expenditure" := FORMAT("P&L Income Expenditure"::" ");
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("P&L Minor Head"; "P&L Minor Head")
                {
                    Caption = 'P&L Minor Head*';
                    Editable = PL_EDITABLE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CASE "P&L Minor Head" OF
                            "P&L Minor Head"::"Administrative & Selling Expenses":
                                Rec."PL Minor Head" := 'Administrative & Selling Expenses';
                            "P&L Minor Head"::Buildings:
                                Rec."PL Minor Head" := 'Buildings';
                            "P&L Minor Head"::"Central Excise Duty Collected":
                                Rec."PL Minor Head" := 'Central Excise Duty Collected';
                            "P&L Minor Head"::"CST Collected":
                                Rec."PL Minor Head" := 'CST Collected';
                            "P&L Minor Head"::"Data Logger":
                                Rec."PL Minor Head" := 'Data Logger';
                            "P&L Minor Head"::Depreciation:
                                Rec."PL Minor Head" := 'Depreciation';
                            "P&L Minor Head"::"Display Board":
                                Rec."PL Minor Head" := 'Display Board';
                            "P&L Minor Head"::"Elec Eqipment":
                                Rec."PL Minor Head" := 'Elec Eqipment';
                            "P&L Minor Head"::"Emp Renumeration & Benefits":
                                Rec."PL Minor Head" := 'Emp Renumeration & Benefits';
                            "P&L Minor Head"::"Excise / Service tax":
                                Rec."PL Minor Head" := 'Excise / Service tax';
                            "P&L Minor Head"::"Financial Charges":
                                Rec."PL Minor Head" := 'Financial Charges';
                            "P&L Minor Head"::GST:
                                Rec."PL Minor Head" := 'GST';
                            "P&L Minor Head"::"GST Collected":
                                Rec."PL Minor Head" := 'GST Collected';
                            "P&L Minor Head"::"Installation - Comm Received":
                                Rec."PL Minor Head" := 'Installation - Comm Received';
                            "P&L Minor Head"::"Insurance Collected":
                                Rec."PL Minor Head" := 'Insurance Collected';
                            "P&L Minor Head"::"Insurance Income":
                                Rec."PL Minor Head" := 'Insurance Income';
                            "P&L Minor Head"::"Krishi Kalyan Cess on ST Collected":
                                Rec."PL Minor Head" := 'Krishi Kalyan Cess on ST Collected';
                            "P&L Minor Head"::Land:
                                Rec."PL Minor Head" := 'Land';
                            "P&L Minor Head"::"LED Utility Lamps":
                                Rec."PL Minor Head" := 'LED Utility Lamps';
                            "P&L Minor Head"::"Manufacturing Scrap":
                                Rec."PL Minor Head" := 'Manufacturing Scrap';
                            "P&L Minor Head"::"Misc. Receipts":
                                Rec."PL Minor Head" := 'Misc. Receipts';
                            "P&L Minor Head"::"New Building Constuction":
                                Rec."PL Minor Head" := 'New Building Constuction';
                            "P&L Minor Head"::"Other Direct Costs":
                                Rec."PL Minor Head" := 'Other Direct Costs';
                            "P&L Minor Head"::"Other Incidental Expences":
                                Rec."PL Minor Head" := 'Other Incidental Expences';
                            "P&L Minor Head"::"Other Sales":
                                Rec."PL Minor Head" := 'Other Sales';
                            "P&L Minor Head"::"Packing & Farwording Charges Collected":
                                Rec."PL Minor Head" := 'Packing & Farwording Charges Collected';
                            "P&L Minor Head"::"Prior Period Adjustments":
                                Rec."PL Minor Head" := 'Prior Period Adjustments';
                            "P&L Minor Head"::"R&D Raw Material Consumed":
                                Rec."PL Minor Head" := 'R&D Raw Material Consumed';
                            "P&L Minor Head"::"RAW Material Consumed":
                                Rec."PL Minor Head" := 'RAW Material Consumed';
                            "P&L Minor Head"::"Service Tax Collected":
                                Rec."PL Minor Head" := 'Service Tax Collected';
                            "P&L Minor Head"::"Servicing Charges Received":
                                Rec."PL Minor Head" := 'Servicing Charges Received';
                            "P&L Minor Head"::"Software Service Collected":
                                Rec."PL Minor Head" := 'Software Service Collected';
                            "P&L Minor Head"::Stock:
                                Rec."PL Minor Head" := 'Stock';
                            "P&L Minor Head"::"Swachh Bharat Cess on ST collected":
                                Rec."PL Minor Head" := 'Swachh Bharat Cess on ST collected';
                            "P&L Minor Head"::VAT:
                                Rec."PL Minor Head" := 'VAT';
                            "P&L Minor Head"::"VAT Collected":
                                Rec."PL Minor Head" := 'VAT Collected';
                            "P&L Minor Head"::"X-Ray Viewers":
                                Rec."PL Minor Head" := 'X-Ray Viewers';
                            ELSE
                                Rec."PL Minor Head" := FORMAT("P&L Minor Head"::" ");
                        END;
                        Rec.MODIFY;
                    end;
                }
            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }

        modify("General Posting Setup")
        {
            Promoted = true;
        }
        modify("VAT Posting Setup")
        {
            Promoted = true;
        }
        modify("G/L Register")
        {
            Promoted = true;
        }

        modify("Detail Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance by Period")
        {
            Promoted = false;
        }
        modify(Action1900210206)
        {
            Promoted = true;
        }
    }

    trigger OnOpenPage()
    begin
        IF USERID IN ['EFFTRONICS\SITARAJYAM', 'EFFTRONICS\RAJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI'] THEN //'EFFTRONICS\SUJANI'
            PL_EDITABLE := TRUE
        ELSE
            PL_EDITABLE := FALSE;

        IF Rec."PL Head" = TRUE THEN BEGIN
            Rec."Reflect in P&L" := Rec."Reflect in P&L"::Yes;
            Rec."Reflect in P&L" := Rec."Reflect in P&L"::Yes;
            Rec.MODIFY;
        END;
        //IF Rec."PL Head" = FALSE THEN "Reflect in P&L" := "Reflect in P&L"::No;
        IF Rec."PL IncomeType" = 'Branch' THEN "PL income Type" := "PL income Type"::Branch;
        IF Rec."PL IncomeType" = 'Direct Incomes' THEN "PL income Type" := "PL income Type"::"Direct Incomes";
        IF Rec."PL IncomeType" = 'Duties & Taxes' THEN "PL income Type" := "PL income Type"::"Duties & Taxes";
        IF Rec."PL IncomeType" = 'Expenditure' THEN "PL income Type" := "PL income Type"::Expenditure;
        IF Rec."PL IncomeType" = 'Fixed Assets' THEN "PL income Type" := "PL income Type"::"Fixed Assets";
        IF Rec."PL IncomeType" = 'Indirect Incomes' THEN "PL income Type" := "PL income Type"::"Indirect Incomes";
        IF Rec."PL IncomeType" = 'Stock' THEN "PL income Type" := "PL income Type"::Stock;
        IF Rec."PL IncomeType" = '' THEN "PL income Type" := "PL income Type"::" ";
        IF Rec."PL Income Type Summary" = 'Stock' THEN "P&L Income Type Summary" := "P&L Income Type Summary"::Stock;
        IF Rec."PL Income Type Summary" = 'Total Expenditure' THEN "P&L Income Type Summary" := "P&L Income Type Summary"::"Total Expenditure";
        IF Rec."PL Income Type Summary" = 'Total Income' THEN "P&L Income Type Summary" := "P&L Income Type Summary"::"Total Income";
        IF Rec."PL Income Type Summary" = '' THEN "P&L Income Type Summary" := "P&L Income Type Summary"::" ";
        IF Rec."PL Minor Head" = 'Administrative & Selling Expenses' THEN "P&L Minor Head" := "P&L Minor Head"::"Administrative & Selling Expenses";
        IF Rec."PL Minor Head" = 'Buildings' THEN "P&L Minor Head" := "P&L Minor Head"::Buildings;
        IF Rec."PL Minor Head" = 'Central Excise Duty Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Central Excise Duty Collected";
        IF Rec."PL Minor Head" = 'CST Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"CST Collected";
        IF Rec."PL Minor Head" = 'Data Logger' THEN "P&L Minor Head" := "P&L Minor Head"::"Data Logger";
        IF Rec."PL Minor Head" = 'Depreciation' THEN "P&L Minor Head" := "P&L Minor Head"::Depreciation;
        IF Rec."PL Minor Head" = 'Display Board' THEN "P&L Minor Head" := "P&L Minor Head"::"Display Board";
        IF Rec."PL Minor Head" = 'Elec Eqipment' THEN "P&L Minor Head" := "P&L Minor Head"::"Elec Eqipment";
        IF Rec."PL Minor Head" = 'Emp Renumeration & Benefits' THEN "P&L Minor Head" := "P&L Minor Head"::"Emp Renumeration & Benefits";
        IF Rec."PL Minor Head" = 'Excise / Service tax' THEN "P&L Minor Head" := "P&L Minor Head"::"Excise / Service tax";
        IF Rec."PL Minor Head" = 'Financial Charges' THEN "P&L Minor Head" := "P&L Minor Head"::"Financial Charges";
        IF Rec."PL Minor Head" = 'GST' THEN "P&L Minor Head" := "P&L Minor Head"::GST;
        IF Rec."PL Minor Head" = 'GST Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"GST Collected";
        IF Rec."PL Minor Head" = 'Installation - Comm Received' THEN "P&L Minor Head" := "P&L Minor Head"::"Installation - Comm Received";
        IF Rec."PL Minor Head" = 'Insurance Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Insurance Collected";
        IF Rec."PL Minor Head" = 'Insurance Income' THEN "P&L Minor Head" := "P&L Minor Head"::"Insurance Income";
        IF Rec."PL Minor Head" = 'Krishi Kalyan Cess on ST Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Krishi Kalyan Cess on ST Collected";
        IF Rec."PL Minor Head" = 'Land' THEN "P&L Minor Head" := "P&L Minor Head"::Land;
        IF Rec."PL Minor Head" = 'LED Utility Lamps' THEN "P&L Minor Head" := "P&L Minor Head"::"LED Utility Lamps";
        IF Rec."PL Minor Head" = 'Manufacturing Scrap' THEN "P&L Minor Head" := "P&L Minor Head"::"Manufacturing Scrap";
        IF Rec."PL Minor Head" = 'Misc. Receipts' THEN "P&L Minor Head" := "P&L Minor Head"::"Misc. Receipts";
        IF Rec."PL Minor Head" = 'New Building Constuction' THEN "P&L Minor Head" := "P&L Minor Head"::"New Building Constuction";
        IF Rec."PL Minor Head" = 'Other Direct Costs' THEN "P&L Minor Head" := "P&L Minor Head"::"Other Direct Costs";
        IF Rec."PL Minor Head" = 'Other Incidental Expences' THEN "P&L Minor Head" := "P&L Minor Head"::"Other Incidental Expences";
        IF Rec."PL Minor Head" = 'Other Sales' THEN "P&L Minor Head" := "P&L Minor Head"::"Other Sales";
        IF Rec."PL Minor Head" = 'Packing & Farwording Charges Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Packing & Farwording Charges Collected";
        IF Rec."PL Minor Head" = 'Prior Period Adjustments' THEN "P&L Minor Head" := "P&L Minor Head"::"Prior Period Adjustments";
        IF Rec."PL Minor Head" = 'R&D Raw Material Consumed' THEN "P&L Minor Head" := "P&L Minor Head"::"R&D Raw Material Consumed";
        IF Rec."PL Minor Head" = 'RAW Material Consumed' THEN "P&L Minor Head" := "P&L Minor Head"::"RAW Material Consumed";
        IF Rec."PL Minor Head" = 'Service Tax Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Service Tax Collected";
        IF Rec."PL Minor Head" = 'Servicing Charges Received' THEN "P&L Minor Head" := "P&L Minor Head"::"Servicing Charges Received";
        IF Rec."PL Minor Head" = 'Software Service Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Software Service Collected";
        IF Rec."PL Minor Head" = 'Stock' THEN "P&L Minor Head" := "P&L Minor Head"::Stock;
        IF Rec."PL Minor Head" = 'Swachh Bharat Cess on ST collected' THEN "P&L Minor Head" := "P&L Minor Head"::"Swachh Bharat Cess on ST collected";
        IF Rec."PL Minor Head" = 'VAT' THEN "P&L Minor Head" := "P&L Minor Head"::VAT;
        IF Rec."PL Minor Head" = 'VAT Collected' THEN "P&L Minor Head" := "P&L Minor Head"::"VAT Collected";
        IF Rec."PL Minor Head" = 'X-Ray Viewers' THEN "P&L Minor Head" := "P&L Minor Head"::"X-Ray Viewers";
        IF Rec."PL Minor Head" = '' THEN "P&L Minor Head" := "P&L Minor Head"::" ";

        IF Rec."PL Income Expenditure" = 'Expenditure' THEN "P&L Income Expenditure" := "P&L Income Expenditure"::Expenditure;
        IF Rec."PL Income Expenditure" = 'Income' THEN "P&L Income Expenditure" := "P&L Income Expenditure"::Income;
        IF Rec."PL Income Expenditure" = '' THEN "P&L Income Expenditure" := "P&L Income Expenditure"::" ";
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF USERID IN ['EFFTRONICS\SITARAJYAM', 'EFFTRONICS\RAJANI', 'EFFTRONICS\SUJANI'] THEN BEGIN
            // IF ((("Reflect in P&L" = "Reflect in P&L"::" ") OR (STRLEN(FORMAT("Reflect in P&L"))<0)) AND (Rec.Reflected_in_pl_datetime <>0DT)) THEN
            IF ((Rec."Reflect in P&L" = Rec."Reflect in P&L"::" ") AND (Rec."PL Head" = FALSE)) THEN
                ERROR('Please Specify whether Head has to Reflect in P&L or not');
            IF (Rec."Reflect in P&L" = Rec."Reflect in P&L"::Yes) THEN BEGIN
                IF (("PL income Type" = "PL income Type"::" ") OR (STRLEN(FORMAT("PL income Type")) < 0)) THEN
                    ERROR('Specify PL Income Type');
                IF (("P&L Income Expenditure" = "P&L Income Expenditure"::" ") OR (STRLEN(FORMAT("P&L Income Expenditure")) < 0)) THEN
                    ERROR('Specify P&L Income Expenditure');
                IF (("P&L Income Type Summary" = "P&L Income Type Summary"::" ") OR (STRLEN(FORMAT("P&L Income Type Summary")) < 0)) THEN
                    ERROR('Specify P&L Income Type Summary');
                IF (("P&L Minor Head" = "P&L Minor Head"::" ") OR (STRLEN(FORMAT("P&L Minor Head")) < 0)) THEN
                    ERROR('Specify P&L Minor Head');
            END;
        END;
    end;

    var
        "PL income Type": Option " ",Branch,"Direct Incomes","Duties & Taxes",Expenditure,"Fixed Assets","Indirect Incomes",Stock;
        "Reflect in P&L": Option " ",Yes,No;
        "P&L Income Type Summary": Option " ",Stock,"Total Expenditure","Total Income";
        "P&L Minor Head": Option " ","Administrative & Selling Expenses",Buildings,"Central Excise Duty Collected","CST Collected","Data Logger",Depreciation,"Display Board","Elec Eqipment","Emp Renumeration & Benefits","Excise / Service tax","Financial Charges",GST,"GST Collected","Installation - Comm Received","Insurance Collected","Insurance Income","Krishi Kalyan Cess on ST Collected",Land,"LED Utility Lamps","Manufacturing Scrap","Misc. Receipts","New Building Constuction","Other Direct Costs","Other Incidental Expences","Other Sales","Packing & Farwording Charges Collected","Prior Period Adjustments","R&D Raw Material Consumed","RAW Material Consumed","Service Tax Collected","Servicing Charges Received","Software Service Collected",Stock,"Swachh Bharat Cess on ST collected",VAT,"VAT Collected","X-Ray Viewers";
        "P&L Income Expenditure": Option " ",Expenditure,Income;
        PL_EDITABLE: Boolean;



}

