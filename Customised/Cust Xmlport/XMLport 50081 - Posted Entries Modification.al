xmlport 50081 "Posted Entries Modification"
{

    schema
    {
        textelement(PostedPurInvoices)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
            }
            textelement(DocNo)
            {
            }
            textelement(PostingDate)
            {
            }
            textelement(BillDate)
            {
            }
            textelement(BillNo)
            {
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

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        GLEntry: Record "G/L Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ValueEntry: Record "Value Entry";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        Pdate: Date;
}

