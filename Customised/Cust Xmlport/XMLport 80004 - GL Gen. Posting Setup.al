xmlport 80004 "G/L Gen. Posting Setup"
{
    Format = VariableText;

    schema
    {
        textelement(GeneralPostingSetup)
        {
            tableelement("<generalpostingsetup>"; "General Posting Setup")
            {
                XmlName = 'GeneralPostingSetup';
                fieldelement(GenBusPostingGroup; "<GeneralPostingSetup>"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "<GeneralPostingSetup>"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(SalesAccount; "<GeneralPostingSetup>"."Sales Account")
                {
                }
                fieldelement(SalesCreditMemoAccount; "<GeneralPostingSetup>"."Sales Credit Memo Account")
                {
                }
                fieldelement(PurchAccount; "<GeneralPostingSetup>"."Purch. Account")
                {
                }
                fieldelement(PurchCreditMemoAccount; "<GeneralPostingSetup>"."Purch. Credit Memo Account")
                {
                }
                fieldelement(COGSAccount; "<GeneralPostingSetup>"."COGS Account")
                {
                }
                fieldelement(InventoryAdjmtAccount; "<GeneralPostingSetup>"."Inventory Adjmt. Account")
                {
                }
                fieldelement(DirectCostAppliedAccount; "<GeneralPostingSetup>"."Direct Cost Applied Account")
                {
                }
                fieldelement(OverheadAppliedAccount; "<GeneralPostingSetup>"."Overhead Applied Account")
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
}

