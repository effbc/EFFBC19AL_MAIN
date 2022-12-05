pageextension 70045 DimensionValueListExt extends "Dimension Value List"
{


    layout
    {



        /*  modify("Control1")
          {



              ShowCaption = false;
          }*/
        modify(Name)
        {
            Editable = NameEditable;
        }


        addafter(Name)
        {
            field(Address1; Rec.Address1)
            {
                ApplicationArea = All;
            }
            field(Address2; Rec.Address2)
            {
                ApplicationArea = All;
            }
        }
        addafter("Dimension Value Type")
        {
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SETRANGE(Blocked, FALSE);
        CodeEditable := FALSE;
        NameEditable := FALSE;
    end;




    var
        [InDataSet]
        CodeEditable: Boolean;
        [InDataSet]
        NameEditable: Boolean;




}

