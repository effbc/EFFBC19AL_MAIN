xmlport 80083 "Inventory Posting Setup"
{
    Format = VariableText;

    schema
    {
        textelement(InventoryPostingSetup)
        {
            tableelement("<inventorypostingsetup>"; "Inventory Posting Setup")
            {
                XmlName = 'InventoryPostingSetup';
                fieldelement(LocationCode; "<InventoryPostingSetup>"."Location Code")
                {
                }
                fieldelement(InvtPostingGroupCode; "<InventoryPostingSetup>"."Invt. Posting Group Code")
                {
                }
                fieldelement(InventoryAccount; "<InventoryPostingSetup>"."Inventory Account")
                {
                }
                fieldelement(UnrealizedProfitAccount; "<InventoryPostingSetup>"."Unrealized Profit Account")
                {
                }
                fieldelement(WIPAccount; "<InventoryPostingSetup>"."WIP Account")
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

