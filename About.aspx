<%@ Page Title="About Us | GST Champions - Excellence in Tax Education" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Discover the story behind GST Champions. We are Bhilwara's premier GST learning portal, dedicated to simplifying taxation through mission-driven education and expert guidance by Parikshit Mathur." />
    <meta name="keywords" content="About GST Champions, Parikshit Mathur Bhilwara, GST Mission Rajasthan, Tax Education India, Best GST Tutors Bhilwara" />
    <link rel="canonical" href="https://www.gstchampions.in/About.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "AboutPage",
      "mainEntity": {
        "@type": "EducationalOrganization",
        "name": "GST Champions",
        "founder": {
          "@type": "Person",
          "name": "GST Champions"
        },
        "location": {
          "@type": "Place",
          "address": {
            "@type": "PostalAddress",
            "addressLocality": "Bhilwara",
            "addressRegion": "Rajasthan",
            "addressCountry": "IN"
          }
        },
        "description": "GST Champions is an educational hub in Rajasthan focused on bridging the gap between theoretical tax law and practical GST implementation."
      }
    }
    </script>

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
        }

        /* --- Compact Hero Section --- */
        .about-hero { 
             background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            color: white; 
            padding: 80px 0; /* Significantly reduced padding */
            /*border-radius: 0 0 40px 40px;*/
            position: relative;
        }

        .fw-900 { font-weight: 900 !important; }

        /* --- Split Layout Container --- */
        .content-grid-wrap { margin-top: -40px; position: relative; z-index: 10; }

        .about-main-card { 
            background: white; 
            border-radius: 30px; 
            box-shadow: 0 20px 50px rgba(0,0,0,0.1); 
            border: 1px solid rgba(0,0,0,0.05);
            overflow: hidden;
        }

        /* Left Side: Story */
        .story-side { padding: 50px; background: white; border-right: 1px solid #f1f5f9; }
        
        /* Right Side: Mission (Visual) */
        .mission-side { 
            padding: 50px; 
            background: linear-gradient(135deg, #1e1b4b 0%, var(--brand-dark) 100%); 
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .icon-badge-modern {
            width: 60px; height: 60px;
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem; margin-bottom: 20px;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        .content-text { line-height: 1.7; color: #475569; font-size: 1.05rem; }
        .text-white .content-text { color: rgba(255,255,255,0.7); }
        
        .section-label { 
            font-size: 0.75rem; 
            font-weight: 900; 
            text-transform: uppercase; 
            letter-spacing: 2px; 
            color: var(--brand-primary); 
            margin-bottom: 10px; 
            display: block; 
        }

        /* --- Compact Stats Strip --- */
        .stats-mini-bar {
            background: #f8fafc;
            padding: 30px 0;
            border-radius: 20px;
            margin-top: 40px;
            border: 1px solid #edf2f7;
        }
        .stat-box h4 { font-weight: 900; color: var(--brand-dark); margin-bottom: 2px; }
        .stat-box p { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; color: #94a3b8; margin: 0; }

        @media (max-width: 991px) {
            .story-side, .mission-side { padding: 30px; }
            .about-hero { padding: 40px 0 60px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="about-hero text-center">
        <div class="container">
            <h2 class="fw-900 mb-2">Our Identity</h2>
            <p class="opacity-50 small text-uppercase tracking-widest pe-3 ps-3">Empowering India with simplified GST Education</p>
        </div>
    </section>

    <div class="container content-grid-wrap mb-5 mt-5">
        <div class="about-main-card">
            <div class="row g-0">
                <div class="col-lg-7 story-side animate__animated animate__fadeInLeft">
                    <span class="section-label">Our Story</span>
                    <h3 class="fw-900 text-dark mb-4">Humari Kahani</h3>
                    <div class="content-text">
                        <asp:Literal ID="litAbout" runat="server"></asp:Literal>
                    </div>
                </div>

                <div class="col-lg-5 mission-side animate__animated animate__fadeInRight">
                    <div class="icon-badge-modern"><i class="fas fa-rocket"></i></div>
                    <span class="section-label text-secondary" style="color: var(--brand-secondary) !important;">The Goal</span>
                    <h3 class="fw-900 text-white mb-4">Mission & Vision</h3>
                    <div class="content-text">
                        <asp:Literal ID="litMission" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>

        <div class="stats-mini-bar shadow-sm">
            <div class="row text-center g-3">
                <div class="col-4 border-end">
                    <div class="stat-box">
                        <h4>2026</h4>
                        <p>Future Ready</p>
                    </div>
                </div>
                <div class="col-4 border-end">
                    <div class="stat-box">
                        <h4>100%</h4>
                        <p>Accuracy</p>
                    </div>
                </div>
                <div class="col-4">
                    <div class="stat-box">
                        <h4>Bhilwara</h4>
                        <p>Rajasthan, India</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container text-center py-4">
        <p class="text-muted small fw-bold text-uppercase tracking-widest opacity-25">GST Champions India • Accuracy Humari Priority Hai</p>
    </div>
</asp:Content>