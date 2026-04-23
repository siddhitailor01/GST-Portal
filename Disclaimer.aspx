<%@ Page Title="Disclaimer & Terms of Service | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="Disclaimer.aspx.cs" Inherits="Disclaimer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="description" content="Read the legal disclaimer, terms and conditions, and privacy policies of GST Champions. We ensure transparency in our tax education and consultancy services in Rajasthan." />
    <meta name="keywords" content="GST Champions Disclaimer, Terms and Conditions, Privacy Policy Bhilwara, Legal Compliance Rajasthan, GST Training Terms" />
    <link rel="canonical" href="https://www.gstchampions.in/Disclaimer.aspx" />
    <meta name="robots" content="noindex, follow" /> <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "WebPage",
      "name": "Disclaimer and Terms - GST Champions",
      "description": "Official legal terms and conditions for using the GST Champions learning portal.",
      "publisher": {
        "@type": "EducationalOrganization",
        "name": "GST Champions",
        "location": {
          "@type": "Place",
          "address": {
            "@type": "PostalAddress",
            "addressLocality": "Bhilwara",
            "addressRegion": "Rajasthan"
          }
        }
      }
    }
    </script>

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-dark: #0f172a;
        }

        .legal-header { 
             background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            color: white; 
            padding: 60px 0 100px; 
            /*border-radius: 0 0 50px 50px;*/
        }

        .legal-card {
            background: white;
            border-radius: 35px;
            padding: 50px;
            margin-top: -60px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.1);
            position: relative;
            z-index: 10;
            border: 1px solid rgba(0,0,0,0.02);
        }

        /* --- High-End Tab Buttons --- */
        .tab-switcher {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 40px;
            background: #f8fafc;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #e2e8f0;
        }

        .tab-btn {
            border: none;
            background: transparent;
            color: #64748b;
            font-weight: 800;
            padding: 14px 35px;
            border-radius: 15px;
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }

        .tab-btn.active {
            background: white;
            color: var(--brand-primary);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }

        /* --- Content Area --- */
        .legal-body {
            line-height: 1.8;
            color: #475569;
            font-size: 1.1rem;
            min-height: 300px;
        }

        /* Database se aane wale heading tags ki styling */
        .legal-body h1, .legal-body h2, .legal-body h3 { 
            color: var(--brand-dark); 
            font-weight: 900; 
            margin-top: 30px;
        }

        .tab-pane-custom { display: none; }
        .tab-pane-custom.active { display: block; animation: fadeIn 0.5s ease; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        
        .fw-900 { font-weight: 900 !important; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="legal-header text-center">
        <div class="container">
            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">COMPLIANCE HUB</span>
            <h1 class="fw-900 mb-2">Legal Transparency</h1>
            <p class="opacity-50 small text-uppercase tracking-widest">Accuracy & Integrity for GST Champions</p>
        </div>
    </div>

    <div class="container mb-5 pb-5 mt-5 pt-5">
        <div class="legal-card animate__animated animate__fadeInUp">
            
            <div class="tab-switcher">
                <button type="button" class="tab-btn active" onclick="switchTab(event, 'tab-disclaimer')">Disclaimer</button>
                <button type="button" class="tab-btn" onclick="switchTab(event, 'tab-terms')">Terms & Conditions</button>
            </div>

            <div class="legal-body">
                <div id="tab-disclaimer" class="tab-pane-custom active">
                    <asp:Literal ID="litDisclaimer" runat="server"></asp:Literal>
                </div>

                <div id="tab-terms" class="tab-pane-custom">
                    <asp:Literal ID="litTerms" runat="server"></asp:Literal>
                </div>
            </div>

        </div>

        <div class="text-center mt-5">
            <p class="text-muted small fw-bold text-uppercase tracking-widest opacity-25">GST Champions • Bhilwara, Rajasthan</p>
        </div>
    </div>

    <script>
        function switchTab(evt, tabId) {
            // Saare content hide karo
            document.querySelectorAll('.tab-pane-custom').forEach(pane => {
                pane.classList.remove('active');
        });

        // Saare buttons se active class hatao
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
        });

        // Current tab dikhao aur button active karo
        document.getElementById(tabId).classList.add('active');
        evt.currentTarget.classList.add('active');
        }
    </script>
</asp:Content>