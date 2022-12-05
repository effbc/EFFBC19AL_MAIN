table 60020 "Inst. PreSite Check List"
{
    // version B2B1.0

    LookupPageID = "Inspection Data Sheet (MPR)";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Sales Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Pre Site Parameter"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Pre Site Check List Parameters";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                PreSiteCheckList: Record "Inst. PreSite Check List";
                PreSiteParameters: Record "Pre Site Check List Parameters";
            begin
                if PreSiteParameters.Get("Pre Site Parameter") then
                    Description := PreSiteParameters.Description;
            end;
        }
        field(4; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(5; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(100; "Set Selection"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sales Order No.", "Sales Order Line No.", "Pre Site Parameter", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }


    procedure Attachments();
    var
        PresiteAttach: Record Attachments;
    begin
        PresiteAttach.Reset;
        PresiteAttach.SetRange("Table ID", DATABASE::"Inst. PreSite Check List");
        PresiteAttach.SetRange("Document No.", "Sales Order No.");
        PresiteAttach.SetRange("Document Line No.", "Line No.");
        PAGE.Run(PAGE::"ESPL Attachments", PresiteAttach);
    end;


    procedure CopyPresite(Rec: Record "Inst. PreSite Check List");
    var
        Selection: Integer;
        Text001: Label '&Presite,Presite &Lines';
        PresiteVisitOrder: Record "Inst. PreSite Check List";
        PreSiteCheckListInsert: Record "Inst. PreSite Check List";
    begin
        /*
        Selection := STRMENU(Text001,1);
        IF Selection = 0 THEN
          EXIT;
        IF Selection = 1 THEN BEGIN
          IF PAGE.RUNMODAL(0,PresiteVisitOrder) = ACTION::LookupOK THEN;
        END ELSE BEGIN
          IF PAGE.RUNMODAL(0,PresiteVisitOrder) = ACTION::LookupOK THEN BEGIN
            PresiteVisitOrder.LOCKTABLE;
            PresiteVisitOrder.SETRANGE("Set Selection",TRUE);
            IF PresiteVisitOrder.FIND('-') THEN
              REPEAT
                PreSiteCheckListInsert."Sales Order No." := Rec."Sales Order No.";
                PreSiteCheckListInsert."Sales Order Line No." := Rec."Sales Order Line No.";
                PreSiteCheckListInsert."Pre Site Parameter" := PresiteVisitOrder."Pre Site Parameter";
                PreSiteCheckListInsert."Line No." := PreSiteCheckListInsert."Line No." + 10000;
                PreSiteCheckListInsert.Description := PresiteVisitOrder.Description;
                PreSiteCheckListInsert.Remarks := PresiteVisitOrder.Remarks;
                PreSiteCheckListInsert.INSERT;
              UNTIL PresiteVisitOrder.NEXT = 0;
            PresiteVisitOrder.SETRANGE(PresiteVisitOrder."Set Selection",TRUE);
            PresiteVisitOrder.MODIFYALL("Set Selection",FALSE);
          END;
        END;
        */
        if PAGE.RunModal(0, PresiteVisitOrder) = ACTION::LookupOK then begin
            PresiteVisitOrder.LockTable;
            PresiteVisitOrder.SetRange("Set Selection", true);
            if PresiteVisitOrder.Find('-') then
                repeat
                    PreSiteCheckListInsert."Sales Order No." := Rec."Sales Order No.";
                    PreSiteCheckListInsert."Sales Order Line No." := Rec."Sales Order Line No.";
                    PreSiteCheckListInsert."Pre Site Parameter" := PresiteVisitOrder."Pre Site Parameter";
                    PreSiteCheckListInsert."Line No." := PreSiteCheckListInsert."Line No." + 10000;
                    PreSiteCheckListInsert.Description := PresiteVisitOrder.Description;
                    PreSiteCheckListInsert.Remarks := PresiteVisitOrder.Remarks;
                    PreSiteCheckListInsert.Insert;
                until PresiteVisitOrder.Next = 0;
            PresiteVisitOrder.SetRange(PresiteVisitOrder."Set Selection", true);
            PresiteVisitOrder.ModifyAll("Set Selection", false);
        end;

    end;
}

