xmlport 50189 "Prod Start Date change"
{
    Format = VariableText;

    schema
    {
        textelement(ProductionOrders)
        {
            tableelement("<productionorder>"; "Production Order")
            {
                XmlName = 'ProductionOrder';
                fieldelement(No; "<ProductionOrder>"."No.")
                {
                }
                fieldelement(ProdStartdate; "<ProductionOrder>"."Prod Start date")
                {
                }
                fieldelement(PlannedDispatchDate; "<ProductionOrder>"."Planned Dispatch Date")
                {
                }

                trigger OnAfterInsertRecord();
                begin
                    //"Production Order".VALIDATE("Production Order"."Prod Start date");
                    PO.Reset;
                    PO.SetFilter(PO.Status, '%1', PO.Status::Released);
                    PO.SetFilter(PO."No.", "<ProductionOrder>"."No.");
                    if PO.FindFirst then begin
                        PO."Planned Dispatch Date" := "<ProductionOrder>"."Planned Dispatch Date";
                        PO."Prod Start date" := "<ProductionOrder>"."Prod Start date";
                        PO.Validate(PO."Prod Start date");
                        "Prod. Order Component".SetRange("Prod. Order Component"."Prod. Order No.", PO."No.");
                        if "Prod. Order Component".FindSet then begin
                            "Prod. Order Component".ModifyAll("Prod. Order Component"."Production Plan Date", PO."Prod Start date")
                        end;
                        PO.Modify;
                    end;
                end;
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
        PO: Record "Production Order";
        "Prod. Order Component": Record "Prod. Order Component";
}

