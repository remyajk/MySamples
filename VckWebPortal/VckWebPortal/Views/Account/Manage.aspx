<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.LocalPasswordModel>" %>

<asp:Content ID="manageTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Manage Account
</asp:Content>

<asp:Content ID="manageContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h2>Eigenen Account managen</h2>
    </hgroup>
     <section id="loginForm">
        <fieldset class="cardedge-border">

        <% if (ViewBag.HasLocalPassword) {
            Html.RenderPartial("_ChangePasswordPartial");
        } else {
            Html.RenderPartial("_SetPasswordPartial");
        } %>
        </fieldset>
     </section>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>