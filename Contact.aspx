<%@ Page Title="Contact Us | GST Champions Bhilwara - Expert GST Support" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="description" content="Have GST queries? Contact GST Champions in Bhilwara, Rajasthan. Our experts are here to provide professional tax support, guidance on HSN codes, and learning assistance." />
    <meta name="keywords" content="Contact GST Champions, GST Support Bhilwara, Tax Expert Rajasthan, Parikshit Mathur Contact, GST Query Help, Bhilwara Tax Consultant" />
    <link rel="canonical" href="https://www.gstchampions.in/Contact.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "LocalBusiness",
      "name": "GST Champions",
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Bhilwara",
        "addressRegion": "Rajasthan",
        "addressCountry": "IN"
      }
    }
    </script>

    <style>
         :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
        }

        /* --- Slim & Powerful Header --- */
        .contact-header { 
 background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;            color: white; 
            padding: 60px 0 100px; 
            /*border-radius: 0 0 50px 50px;*/ 
            position: relative;
            overflow: hidden;
        }

        .contact-header::after {
            content: '';
            position: absolute;
            top: -20%; right: -5%; width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(168, 85, 247, 0.15) 0%, transparent 70%);
        }

        /* --- Main Layout: Overlapping Grid --- */
        .contact-main-grid { margin-top: -60px; position: relative; z-index: 10; }

        .form-side { 
            background: white; 
            border-radius: 35px; 
            padding: 50px; 
            box-shadow: 0 30px 60px rgba(0,0,0,0.08); 
            border: 1px solid rgba(0,0,0,0.03);
        }

        .info-side { 
            background: linear-gradient(135deg, #1e1b4b 0%, var(--brand-dark) 100%); 
            border-radius: 35px; 
            padding: 50px; 
            color: white;
            box-shadow: 0 30px 60px rgba(15, 23, 42, 0.2);
            height: 100%;
        }

        /* --- Input Styling --- */
        .form-label { font-weight: 800; color: #64748b; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; }
        
        .form-control { 
            background: #f8fafc; 
            border: 1px solid #e2e8f0; 
            border-radius: 15px; 
            padding: 14px 20px; 
            font-weight: 600;
            transition: 0.3s;
        }

        .form-control:focus { 
            background: white; 
            border-color: var(--brand-primary); 
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.1); 
        }

        /* --- Info Items --- */
        .contact-pill {
            display: flex;
            align-items: center;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 20px;
            margin-bottom: 20px;
            transition: 0.3s;
        }

        .contact-pill:hover { background: rgba(255,255,255,0.08); transform: translateX(10px); }

        .icon-circle-sm {
            width: 50px; height: 50px;
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; margin-right: 20px;
            box-shadow: 0 8px 15px rgba(99, 102, 241, 0.3);
        }

        .btn-send-modern {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            color: white !important;
            border: none;
            border-radius: 15px;
            padding: 15px 40px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.4s;
            width: 100%;
        }

        .btn-send-modern:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 15px 30px rgba(168, 85, 247, 0.4); 
        }

        .map-frame { 
            border-radius: 30px; 
            overflow: hidden; 
            height: 300px; 
            margin-top: 30px; 
            border: 1px solid rgba(255,255,255,0.1);
            filter: grayscale(1) invert(0.9) contrast(1.2); /* Dark Map mode */
        }

        .fw-900 { font-weight: 900 !important; }

        @media (max-width: 991px) {
            .form-side, .info-side { padding: 30px; }
            .article-title { font-size: 2.2rem; }
        }    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="contact-header text-center animate__animated animate__fadeIn">
        <div class="container">
            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">CONNECT WITH US</span>
            <h1 class="display-4 fw-900 mb-2">Get In Touch</h1>
            <p class="lead opacity-50 mx-auto" style="max-width: 600px;">Bhilwara's experts are here to help in Rajasthan.</p>
        </div>
    </section>

    <div class="container contact-main-grid mb-5 mt-5">
        <div class="row g-4">
            <div class="col-lg-7">
                <div class="form-side animate__animated animate__fadeInLeft shadow-lg">
                    <h3 class="fw-900 text-dark mb-4">Send an Inquiry</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Your Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                                ErrorMessage="Naam likhna zaroori hai!" CssClass="err-msg" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="col-md-6">
                            <label class="form-label">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@mail.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Email address khali nahi ho sakta!" CssClass="err-msg" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                ErrorMessage="Format galat hai (e.g. siddhi@gmail.com)" CssClass="err-msg" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Inquiry Type</label>
                            <asp:DropDownList ID="ddlInquiryType" runat="server" CssClass="form-control">
                                <asp:ListItem Value="General" Text="General Inquiry"></asp:ListItem>
                                <asp:ListItem Value="Topic Doubt" Text="Topic Doubt"></asp:ListItem>
                                <asp:ListItem Value="Feedback" Text="Feedback/Suggestions"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Subject</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="What is your query about?"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject" 
                                ErrorMessage="Subject likhna zaroori hai!" CssClass="err-msg" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Message Details</label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Write your message here..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                                ErrorMessage="Message box khali hai!" CssClass="err-msg" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-12">
                            <asp:Button ID="btnSend" runat="server" Text="Dispatch Message" CssClass="btn-send-modern" OnClick="btnSend_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="info-side animate__animated animate__fadeInRight">
                    <h3 class="fw-900 mb-4">Contact Info</h3>
                   <div class="contact-pill"><div class="icon-circle-sm"><i class="fas fa-phone"></i></div><div><h6 class="fw-900 mb-0">Contact Us</h6><a href="tel:+919829047112" class="small opacity-50 mb-0" style="text-decoration:none; color:white;">+91 9829047112</a></div></div>
                    <div class="contact-pill"><div class="icon-circle-sm"><i class="fas fa-map-marker-alt"></i></div><div><h6 class="fw-900 mb-0">Our Location</h6><p class="small opacity-50 mb-0">First Floor, 20-21, LBS Market, Nr. Gol Pyau Choraha, Bhilwara</p></div></div>
                    <div class="contact-pill"><div class="icon-circle-sm"><i class="fas fa-envelope-open-text"></i></div><div><h6 class="fw-900 mb-0">Direct Email</h6><p class="small opacity-50 mb-0">support@gstchampions.in</p></div></div>
                    <div class="map-frame">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3618.322831093121!2d74.6369!3d25.3444!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMjXCsDIwJzM5LjgiTiA3NMKwMzgnMTIuOCJF!5e0!3m2!1sen!2sin!4v1620000000000!5m2!1sen!2sin" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>