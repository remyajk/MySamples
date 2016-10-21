<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="contactTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Kontakt - Value Card Kiosk
</asp:Content>

<asp:Content ID="contactContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h2><%: ViewBag.Message %></h2>
    </hgroup>
    <div class="cardedge-border">
    <section class="contact">
        <header>
            <h3>Telefon:</h3>
        </header>
        <p>
            <span>+41 76 50 40 666</span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Email:</h3>
        </header>
        <p>
            <span class="label">Support:</span>
            <span><a href="mailto:admin@cardedge.ch">admin@cardedge.ch</a></span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Adresse:</h3>
        </header>
        <p>
           CardEdge GmbH<br />
           Industriestrasse 15<br />
           CH-5432 Neuenhof
        </p>
    </section>
        </div>
</asp:Content>