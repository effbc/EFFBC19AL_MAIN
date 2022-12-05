table 33000913 "Issue Tracker Line"
{
    DataClassification = CustomerContent;
    // version TRACK


    fields
    {
        field(1; "Issue Id"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Detailed Descrption"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Logged DateTime"; DateTime)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Logged By"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Issue Id", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        IssueTrackHeadGRec.Reset;
        IssueTrackHeadGRec.Get("Issue Id");
        if IssueTrackHeadGRec.Status <> IssueTrackHeadGRec.Status::" " then
            Error('Acces Denied. You cannot delete');
    end;

    trigger OnInsert();
    begin
        "Logged By" := UserId;
        "Logged DateTime" := CurrentDateTime;

        IssueTrackHeadGRec.Reset;
        IssueTrackHeadGRec.Get("Issue Id");
        if (IssueTrackHeadGRec.Status = IssueTrackHeadGRec.Status::Compeleted) or
           (IssueTrackHeadGRec.Status = IssueTrackHeadGRec.Status::closed) then
            Error('You cannot update,Issue has been already completed/closed. Please reopen the document for any changes.');
    end;

    trigger OnModify();
    begin
        IssueTrackHeadGRec.Reset;
        IssueTrackHeadGRec.Get("Issue Id");
        if (IssueTrackHeadGRec.Status = IssueTrackHeadGRec.Status::Compeleted) or
           (IssueTrackHeadGRec.Status = IssueTrackHeadGRec.Status::closed) then
            Error('You cannot delete,Issue has been already completed/closed. Please reopen the document for any changes.');
    end;

    var
        IssueTrackHeadGRec: Record "Issue Track Header";
}

