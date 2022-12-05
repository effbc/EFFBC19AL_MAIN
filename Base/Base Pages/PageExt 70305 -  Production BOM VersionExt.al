pageextension 70305 "Production BOM Version" extends "Production BOM Version"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;

            }
        }
        addafter("Last Date Modified")
        {
            field("Modified User ID"; Rec."Modified User ID")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Copy BOM &Version")
        {
            action("Copy BOM")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD("Version Code");
                    IF PAGE.RUNMODAL(0, ProdBOMHeader) = ACTION::LookupOK THEN
                        "Custom Events".CopyBomVersion(ProdBOMHeader."No.", '', Rec, Rec."Version Code");
                end;
            }
        }
    }

    var
        myInt: Integer;
        ProdBOMHeader: Record "Production BOM Header";
        ProductionBOMCopy: Codeunit "Production BOM-Copy";
        "Custom Events": Codeunit 50035;
}