pageextension 70288 EmployeePictureExt extends "Employee Picture"
{
    layout
    {
        addfirst(content)
        {
            field(Signature; Rec.Signature)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {

    }

    var
        SignExists: Boolean;
        Text003: Label 'Do you want to replace the existing Signature of %1 %2?';
        Text004: Label 'Do you want to delete the Signature of %1 %2?';
}