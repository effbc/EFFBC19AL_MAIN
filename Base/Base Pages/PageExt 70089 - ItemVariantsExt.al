pageextension 70089 ItemVariantsExt extends 5401
{
    // version NAVW17.00

    layout
    {



        /*  modify("Control1")
          {



              ShowCaption = false;
          }*/



        addafter(Code)
        {
            field("Operating Temperature"; Rec."Operating Temperature")
            {
                ApplicationArea = All;
            }
            field("Storage Temperature"; Rec."Storage Temperature")
            {
                ApplicationArea = All;
            }
            field(Package; Rec.Package)
            {
                ApplicationArea = All;
            }
            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
            }
        }

        addafter(Description)
        {
            field("Item Status"; Rec."Item Status")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        /*{
              IF UPPERCASE(USERID) IN ['EFFTRONICS\PARVATHI', 'EFFTRONICS\VIJAYA', 'SUPER', 'EFFTRONICS\ANUSHAG', 'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\KARUNA', 'EFFTRONICS\NAGAGAYATRI', 'EFFTRONICS\SUPRIYA'] THEN
         CurrPage.EDITABLE := TRUE
     ELSE
         CurrPage.EDITABLE := FALSE;
              }*/

        //added by Vishnu Priya on 10-08-2019
        IF NOT (MAIL.Permission_Checking(USERID, 'ITEM-VARIENT-RIGHTS'))
          THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
        //end by Vishnu Priya on 10-08-2019
    end;

    var
        MAIL: Codeunit "Custom Events";




}

