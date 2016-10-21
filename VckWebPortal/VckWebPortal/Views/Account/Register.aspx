<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h2>Registrierung</h2>
    </hgroup>
    <section id="loginForm">
        <% using (Html.BeginForm())
           { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.ValidationSummary() %>
        <% if (Request.IsAuthenticated || !Model.UserExists)
           { %>
        <fieldset class="cardedge-border">
            <legend>Registration Form</legend>
            <ol>
                <li>
                    <%: Html.LabelFor(m => m.UserName) %>
                    <%: Html.TextBoxFor(m => m.UserName) %>
                </li>
                <li>
                    <%: Html.LabelFor(m => m.Password) %>
                    <%: Html.PasswordFor(m => m.Password) %>
                </li>
                <li>
                    <%: Html.LabelFor(m => m.ConfirmPassword) %>
                    <%: Html.PasswordFor(m => m.ConfirmPassword) %>
                </li>
                <li>
                    <% if (!Model.UserExists)
                       { %>
                    <%: Html.HiddenFor(m => m.IsAdmin, new { Value = true})%>
                    <% } %>
                    <% if (Model.UserExists)
                       { %>
                    <%: Html.LabelFor(m => m.IsAdmin) %>
                    <%= Html.CheckBoxFor(m => m.IsAdmin, new { @checked = "checked" })%>
                    <% } %>
                </li>
            </ol>
            <input type="submit" value="Registrieren" />
        </fieldset>
        <% }
           else
           { %>
        <fieldset class="cardedge-border">
            <legend>Registration Form</legend>
            <ol>
                <li>Registrierung neuer User nur mit gültigem und authentifiziertem Useraccount möglich.
                </li>
            </ol>
        </fieldset>
        <% } %>
        <% } %>
    </section>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
