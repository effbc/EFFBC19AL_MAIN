table 33000916 PCB
{
    DataClassification = CustomerContent;
    // sten.RESET;
    // sten.SETRANGE(sten."No.",Stencil);
    // IF PAGE.RUNMODAL(60239,sten) = ACTION:: LookupOK THEN
    //  Stencil:= sten."No.";
    // 2.0      UPGREV                        Code Reviewed and Field validate "Master PCB" record more than once retrived issue resolved.


    fields
    {
        field(1; "PCB No."; Code[20])
        {
            TableRelation = Item."No." WHERE("Product Group Code Cust" = FILTER('PCB' | 'CPCB' | 'MPCB'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item.Get("PCB No.") then
                    Description := Item.Description;
            end;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "PCB Thickness"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Copper Clad Thinkness"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "PCB Area"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; Length; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; Width; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "PCB Shape"; Enum "Item Pcb")
        {

            DataClassification = CustomerContent;
        }
        field(9; "On C-side"; Enum "Item Cside")
        {

            DataClassification = CustomerContent;
        }
        field(10; "On D-side"; Enum "Item Cside")
        {

            DataClassification = CustomerContent;
        }
        field(11; "On S-side"; Enum "Item Cside")
        {

            DataClassification = CustomerContent;
        }
        field(12; Stencil; Code[20])
        {
            TableRelation = Stencil."No.";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                sten.Reset;
                if PAGE.RunModal(60238, sten) = ACTION::LookupOK then
                    Validate(Stencil, sten."No.");
            end;

            trigger OnValidate();
            begin
                Item.Reset;
                Item.SetFilter(Item."No.", "PCB No.");
                if Item.FindFirst then begin
                    if Item."Product Group Code Cust" = 'MPCB' then begin
                        PcbGRec.Reset;
                        PcbGRec.SetFilter(PcbGRec."Master PCB", "PCB No.");
                        if PcbGRec.FindSet then
                                repeat
                                    PcbGRec.Stencil := Stencil;
                                    PcbGRec.Modify;
                                until PcbGRec.Next = 0;
                    end else
                        if Item."Product Group Code Cust" = 'PCB' then begin
                            PBL.Reset;
                            PBL.SetFilter(PBL."No.", "PCB No.");
                            if PBL.FindFirst then
                                    repeat
                                        PcbGRec.Reset;
                                        PcbGRec.SetFilter(PcbGRec."PCB No.", PBL."Production BOM No.");
                                        if PcbGRec.FindFirst then begin
                                            PcbGRec.Stencil := Stencil;
                                            PcbGRec.Modify;
                                        end;
                                    until PBL.Next = 0;
                        end;
                end;
            end;
        }
        field(13; "Soldering Area"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Master PCB"; Code[20])
        {
            TableRelation = Item."No." WHERE("Product Group Code Cust" = FILTER('MPCB'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                PcbGRec.Reset;
                //IF PcbGRec.GET("Master PCB") THEN //UPGREV2.0
                PcbGRec.SetRange(PcbGRec."PCB No.", "Master PCB");
                if PcbGRec.FindFirst then
                    Stencil := PcbGRec.Stencil;
            end;
        }
        field(15; Multiples_Per_Stencil; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Double Side Stencil"; Code[20])
        {
            TableRelation = Stencil."No.";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                sten.Reset;
                if PAGE.RunModal(60238, sten) = ACTION::LookupOK then
                    Validate(Stencil, sten."No.");
            end;

            trigger OnValidate();
            begin
                Item.Reset;
                Item.SetFilter(Item."No.", "PCB No.");
                if Item.FindFirst then begin
                    if Item."Product Group Code Cust" = 'MPCB' then begin
                        PcbGRec.Reset;
                        PcbGRec.SetFilter(PcbGRec."Master PCB", "PCB No.");
                        if PcbGRec.FindSet then
                            repeat
                                    PcbGRec.Stencil := Stencil;
                                PcbGRec.Modify;
                            until PcbGRec.Next = 0;
                    end else
                        if Item."Product Group Code Cust" = 'PCB' then begin
                            PBL.Reset;
                            PBL.SetFilter(PBL."No.", "PCB No.");
                            if PBL.FindFirst then
                                repeat
                                        PcbGRec.Reset;
                                    PcbGRec.SetFilter(PcbGRec."PCB No.", PBL."Production BOM No.");
                                    if PcbGRec.FindFirst then begin
                                        PcbGRec.Stencil := Stencil;
                                        PcbGRec.Modify;
                                    end;
                                until PBL.Next = 0;
                        end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "PCB No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        sten: Record Stencil;
        Item: Record Item;
        PcbGRec: Record PCB;
        PBL: Record "Production BOM Line";
}

