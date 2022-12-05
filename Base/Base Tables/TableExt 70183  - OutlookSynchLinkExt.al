tableextension 70183 OutlookSynchLinkExt extends "Outlook Synch. Link"
{
    fields
    {
        modify("User ID")
        {
            TableRelation = User."User Name";
        }
    }
}