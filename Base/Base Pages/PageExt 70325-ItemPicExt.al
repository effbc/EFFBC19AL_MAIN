pageextension 70325 ItemPictExt extends "Item Picture"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify(ExportFile)
        {
            Visible = false;
        }
        addafter(ImportPicture)
        {
            action(ExportFileCust)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = IsEnabledPic;
                Image = Export;
                ToolTip = 'Export the picture to a file.';
                Visible = IsEnabledPic;

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    TestField("No.");
                    TestField(Description);


                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Delchr("No.", '=', '/') + Format(Picture.MediaId);
                    Picture.ExportFile(ExportPath + '.' + DummyPictureEntity.GetDefaultExtension);

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()


    begin
        IsEnabledPic := (Rec.Picture.Count <> 0);
    end;

    var
        IsEnabledPic: boolean;


}