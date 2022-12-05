page 60053 "Item Specification"
{
    // version B2B1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Item Specification";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Specification Code"; Rec."Specification Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        DuplicateItems: Record "Alternate Items";
        ItemSpecifications: Record "Item Specification";
    begin
        //MESSAGE('Restarting....');
        CLEAR(TempCount);
        CLEAR(CountSpec);
        Flag := TRUE;
        CLEAR(ItemSpecifications);
        CLEAR(SubSpecific);
        CLEAR(MainSpecific);
        CLEAR(CheckCount);


        ItemSpecifications.SETCURRENTKEY(ItemSpecifications."Item No.");
        ItemSpecifications.SETRANGE("Item No.", Rec."Item No.");
        ItemSpecifications.SETRANGE("Product Group Code", Rec."Product Group Code");
        ItemSpecifications.SETRANGE("Item Category Code", Rec."Item Category Code");
        ItemSpecifications.SETRANGE("Item Sub Group Code", Rec."Item Sub Group Code");
        ItemSpecifications.SETRANGE("Item Sub Sub Group Code", Rec."Item Sub Sub Group Code");
        //ItemSpecifications.SETRANGE("Specification Code","Specification Code");
        CountSpec := ItemSpecifications.COUNT;
        //ItemSpecifications.FINDFIRST;
        IF NOT ItemSpecifications.FINDFIRST THEN
            EXIT(TRUE) ELSE BEGIN
            SubSpecific.SETCURRENTKEY(SubSpecific."Item No.");
            SubSpecific.FINDFIRST;
            MainSpecific.SETCURRENTKEY(MainSpecific."Item No.");
            MainSpecific.FINDFIRST;
            REPEAT
                SubSpecific.SETRANGE("Item No.", MainSpecific."Item No.");
                SubSpecific.SETRANGE("Product Group Code", Rec."Product Group Code");
                SubSpecific.SETRANGE("Item Category Code", Rec."Item Category Code");
                SubSpecific.SETRANGE("Item Sub Group Code", Rec."Item Sub Group Code");
                SubSpecific.SETRANGE("Item Sub Sub Group Code", Rec."Item Sub Sub Group Code");
                //SubSpecific.SETRANGE("Specification Code","Specification Code");
                IF NOT SubSpecific.FINDFIRST THEN;// EXIT(TRUE);
                IF SubSpecific."Item No." <> ItemSpecifications."Item No." THEN BEGIN
                    //MESSAGE('SubSpecific.COUNT : %1',SubSpecific.COUNT);
                    //MESSAGE('CountSpec : %1',CountSpec);
                    IF SubSpecific.COUNT = CountSpec THEN BEGIN
                        ItemSpecifications.FINDFIRST;
                        CheckCount := 0;
                        REPEAT
                            TempCount := 1;
                            SubSpecific.FINDFIRST;
                            WHILE (TempCount <= CountSpec) DO BEGIN
                                TempCount := TempCount + 1;
                                IF (ItemSpecifications."Specification Code" <> SubSpecific."Specification Code") OR
                                  (ItemSpecifications.Value <> SubSpecific.Value) THEN
                                    Flag := FALSE
                                ELSE
                                    CheckCount := CheckCount + 1;
                                SubSpecific.NEXT;
                            END;
                        UNTIL ItemSpecifications.NEXT = 0;
                        IF CheckCount = CountSpec THEN BEGIN
                            IF NOT CONFIRM('THIS SPECIFICATION EXIST FOR ONE OF THE ITEMS,DO YOU WANT TO CHANGE') THEN BEGIN
                                ItemSpecifications.DELETEALL;
                                EXIT(TRUE)
                            END ELSE
                                EXIT(FALSE);
                        END;
                    END;
                END;
            UNTIL MainSpecific.NEXT = 0;
        END;
    end;

    var
        ItemRec: Record Item;
        ItemSpecificationRec: Record "Item Specification";
        ItemSpecificTest: Record "Item Specification";
        CountSpec: Integer;
        MainSpecific: Record "Item Specification";
        SubSpecific: Record "Item Specification";
        TempCount: Integer;
        Flag: Boolean;
        CheckCount: Integer;
}

