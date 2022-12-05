pageextension 70012 AssemblyBomExt extends 36
{
    layout
    {

    }
    actions
    {
        modify("E&xplode BOM")
        {
            Promoted = true;
        }
        modify(CalcStandardCost)
        {
            Promoted = true;
        }
        modify(CalcUnitPrice)
        {
            Promoted = true;
        }
        addafter("E&xplode BOM")
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Action1000000001)
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit "BOM-Explode BOM";
                    ApplicationArea = All;
                }
                separator(Action1000000002)
                {
                }
                action("Copy &Assembly")
                {
                    Caption = 'Copy &Assembly';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF PAGE.RUNMODAL(31, Item) = ACTION::LookupOK THEN BEGIN
                            BomComponent.SETRANGE("Parent Item No.", Item."No.");
                            IF BomComponent.FINDSET THEN
                                REPEAT
                                    TOBomComponent.INIT;
                                    TOBomComponent."Parent Item No." := Rec."Parent Item No.";
                                    TmpBomComponent.SETRANGE("Parent Item No.", Rec."Parent Item No.");
                                    IF TmpBomComponent.FINDLAST THEN
                                        TOBomComponent."Line No." := TmpBomComponent."Line No." + 10000
                                    ELSE
                                        TOBomComponent."Line No." := BomComponent."Line No.";
                                    TOBomComponent.Type := BomComponent.Type;
                                    TOBomComponent.VALIDATE("No.", BomComponent."No.");
                                    TOBomComponent.VALIDATE("Quantity per", BomComponent."Quantity per");
                                    TOBomComponent.Position := BomComponent.Position;
                                    TOBomComponent."Position 2" := BomComponent."Position 2";
                                    TOBomComponent."Position 3" := BomComponent."Position 3";
                                    TOBomComponent."Machine No." := BomComponent."Machine No.";
                                    TOBomComponent."Lead-Time Offset" := BomComponent."Lead-Time Offset";
                                    TOBomComponent."Variant Code" := BomComponent."Variant Code";
                                    TOBomComponent."Installed in Line No." := BomComponent."Installed in Line No.";
                                    TOBomComponent."Installed in Item No." := BomComponent."Installed in Item No.";
                                    TOBomComponent."Assembly BOM" := BomComponent."Assembly BOM";
                                    TOBomComponent."BOM Description" := BomComponent."BOM Description";
                                    TOBomComponent.INSERT;
                                UNTIL BomComponent.NEXT = 0;
                        END;
                    end;
                }
            }
        }
    }

    var
        BomComponent: Record "BOM Component";
        //CopyAssembly: Report "QCinspection details";
        Item: Record Item;
        TOBomComponent: Record "BOM Component";
        TmpBomComponent: Record "BOM Component";
}

