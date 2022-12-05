xmlport 60002 "Material Issues Header Data"
{
    Format = VariableText;

    schema
    {
        textelement(MaterialIssueHeader)
        {
            tableelement("Material Issue Header"; "Material Issue Header")
            {
                XmlName = 'MaterialIssueHeader';
                fieldelement(No; "Material Issue Header"."No.")
                {
                }
                fieldelement(TranferFromCode; "Material Issue Header"."Transfer-from Code")
                {
                }
                fieldelement(TransferToCode; "Material Issue Header"."Transfer-to Code")
                {
                }
                fieldelement(PostingDate; "Material Issue Header"."Posting Date")
                {
                }
                fieldelement(ShortcutDim1; "Material Issue Header"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ShortcutDim2; "Material Issue Header"."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(ProdOrderNo; "Material Issue Header"."Prod. Order No.")
                {
                }
                fieldelement(ProdOrderLineNo; "Material Issue Header"."Prod. Order Line No.")
                {
                }
                fieldelement(ResName; "Material Issue Header"."Resource Name")
                {
                }
                fieldelement(UserId; "Material Issue Header"."User ID")
                {
                }
                fieldelement(DueDate; "Material Issue Header"."Due Date")
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

