<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    About - Value Card Kiosk
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h2><%: ViewBag.Message %></h2>
    </hgroup>

    <article class="cardedge-border" style="width:100%" >
        <p>
            Damit Sie den VCK finanztechnisch administrieren können, stellen wir Ihnen diese WEB-Applikation zur Verfügung. <br />
            Der VCK arbeitet grundsätzlich lokal, d.h alle durchgefühlten Transaktionen und Prozesse werden in einer lokalen Datenbank gespeichert, die mittels diesem Portal sichtbar gemacht werden.
        </p>

        <p>
            Funktionen:
            <br />  &#10003;Bargeldbestand anzeigen (Geld zur Kasse Münzen)
<br />  &#10003;Bargeldbestand anzeigen Scheine
<br />  &#10003;EFT Terminal-Umsatz
<br />  &#10003;Kartenbestand anzeigen Fach (Karten im Magazin des Kartendruckers)
<%--<br />  &#10003;Kartenbestand setzen für Stacker--%>
<br />  &#10003;Kassenschnitt durchführen (Münzen und Scheine)
<br />  &#10003;Transaktionssuche anhand von Datum, Uhrzeit und/oder Kreditkartennummer, Transaktionsnummer 
oder Kartennummer
<br />  &#10003;Ausdruck Statistik
        </p>
    </article>
</asp:Content>