tableextension 70039 ResJournalLineExt extends "Res. Journal Line"
{
    fields
    {
        field(60000; Zones; Code[10])
        {
            Caption = 'Zones';
            DataClassification = CustomerContent;
            //TableRelation = Zones;
        }
        field(60001; Division; Code[10])
        {
            Caption = 'Divsion';
            DataClassification = CustomerContent;
            //TableRelation = Table50012.Field1 WHERE(Field2 = FIELD(Zones));
        }
        field(60002; Station; Code[10])
        {
            Caption = 'Station';
            DataClassification = CustomerContent;
            //TableRelation = Table50013.Field1 WHERE(Field2 = FIELD(Division));
        }
        field(60003; "Product type"; Code[10])
        {
            Caption = 'Product type';
            TableRelation = "Service Item Group".Code;
            DataClassification = CustomerContent;
        }
        field(60004; "Sale order no"; Code[30])
        {
            Caption = 'Sale order no';
            TableRelation = "Sales Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60005; Status; Enum Status3)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;

        }
        field(60006; "Work Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60007; "Planned Hr's"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60008; "Serial no"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60009; State; Code[10])
        {
            DataClassification = CustomerContent;
            //TableRelation = State.Code;
        }
        field(60010; District; Code[10])
        {
            DataClassification = CustomerContent;
            //TableRelation = Table50014.Field1 WHERE(Field2 = FIELD(State));
        }
        field(60011; City; Code[10])
        {
            TableRelation = City."City Code" WHERE("District Code" = FIELD(District));
            DataClassification = CustomerContent;
        }
        field(60012; Place; Code[10])
        {
            TableRelation = Place."Place Code";
            DataClassification = CustomerContent;
        }
        field(60013; "Training/Demo"; Enum "Training Demo")
        {
            DataClassification = CustomerContent;

        }
        field(60014; Location; Code[10])
        {
            Caption = 'Department';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
        field(60015; Designation; Code[10])
        {
            TableRelation = "Resource Group"."No.";
            DataClassification = CustomerContent;
        }
        field(60016; "Action taken"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60017; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60018; Reason; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Service item"; Code[20])
        {
            TableRelation = "Service Item"."No." WHERE(Station = FIELD(Station));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Station);
                TestField("Service item");
                //if serviceitem."No."<>xRec."Service item" then
                //serviceitem.GET(xRec."Service item");
                //MESSAGE(Rec."Service item");
                //serviceitem.SETRANGE(serviceitem."No.",xRec."Service item");
                serviceitem.Get(Rec."Service item");
                "Serial no" := serviceitem."Serial No.";
                //xRec.MODIFY;
                //MESSAGE(xRec."Serial No");
            end;
        }
        field(60020; "AMC Order NO"; Code[30])
        {
            TableRelation = "Service Contract Header"."Contract No.";
            DataClassification = CustomerContent;
        }
        field(60021; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        serviceitem: Record "Service Item";
        machinecenter: Record "Machine Center";
}

