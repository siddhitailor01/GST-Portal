<%@ Page Title="GST Knowledge Hub | Latest GST Updates & Guides | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="KnowledgeHub.aspx.cs" Inherits="KnowledgeHub" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Stay updated with the latest GST news, simplified guides, and tax compliance articles. Your go-to resource for GST intelligence in Rajasthan, curated by Parikshit Mathur." />
    <meta name="keywords" content="GST Updates 2026, GST Blog Rajasthan, Tax News India, GST Compliance Guide, HSN Updates, Bhilwara Tax Hub" />
    <link rel="canonical" href="https://www.gstchampions.in/KnowledgeHub.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "CollectionPage",
      "name": "GST Knowledge Hub - GST Champions",
      "description": "A collection of simplified GST guides and real-time tax updates for students and professionals.",
      "publisher": {
        "@type": "Organization",
        "name": "GST Champions",
        "logo": "https://www.gstchampions.in/images/logo.png"
      }
    }
    </script>

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
        }

        /* --- Hub Header --- */
        .hub-header { 
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            color: white; 
            padding: 80px 0 60px; 
            /*border-radius: 0 0 50px 50px;*/
            position: relative;
            overflow: hidden;
        }

        /* --- Elegant Blog Cards --- */
        .blog-card { 
            border: 1px solid rgba(0,0,0,0.05); 
            border-radius: 28px; 
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); 
            overflow: hidden; 
            height: 100%; 
            background: #fff; 
            display: flex;
            flex-direction: column;
        }

        .blog-card:hover { 
            transform: translateY(-12px); 
            box-shadow: 0 30px 60px rgba(15, 23, 42, 0.12); 
            border-color: var(--brand-primary);
        }

        /* --- Image Fixing Logic --- */
        .blog-img-container {
            position: relative;
            /*height: 220px; /* Fixed viewport height */
            background: #f8fafc; /* Light gray base for mismatched images */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-bottom: 1px solid #f1f5f9;
        }

        .blog-img { 
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain; /* Ensures the FULL image is shown without cutting */
            transition: 0.5s;
        }

        .blog-card:hover .blog-img {
            transform: scale(1.05);
        }

        /* --- UI Elements --- */
        .date-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(8px);
            color: var(--brand-dark);
            padding: 5px 12px;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 800;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .card-body { padding: 25px; flex-grow: 1; display: flex; flex-direction: column; }
        
        .card-title { 
            font-size: 1.25rem; 
            font-weight: 900 !important;
            color: var(--brand-dark); 
            margin-bottom: 12px;
            line-height: 1.3;
        }

        .short-desc {
            color: #64748b;
            font-size: 0.9rem;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .continue-btn {
            font-weight: 800;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--brand-primary);
            text-decoration: none;
            margin-top: auto;
            display: inline-flex;
            align-items: center;
        }

        .continue-btn i { transition: 0.3s; margin-left: 8px; }
        .blog-card:hover .continue-btn i { transform: translateX(5px); }

        .hr-soft { opacity: 0.05; margin: 15px 0; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="hub-header text-center">
        <div class="container">
            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill mb-3 fw-bold">GST INSIGHTS</span>
            <h1 class="fw-900 display-5 mb-2">Knowledge Hub</h1>
            <p class="lead opacity-75 mx-auto" style="max-width: 600px;">Simplified guides and real-time GST updates.</p>
        </div>
    </div>

    <div class="container my-5 py-2">
        <div class="row g-4">
            <asp:Repeater ID="rptBlogs" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4">
                        <div class="card blog-card shadow-sm">
                            <div class="blog-img-container">
                                <img src='admin/uploads/blogs/<%# Eval("ImagePath") %>' class="blog-img" alt="GST Article">
                                <div class="date-badge">
                                    <i class="far fa-calendar-alt me-1 text-primary"></i> <%# Eval("CreatedDate", "{0:dd MMM yyyy}") %>
                                </div>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("Title") %></h5>
                                <p class="short-desc"><%# Eval("ShortDesc") %></p>
                                
                                <hr class="hr-soft" />
                                
                                <a href='BlogDetail.aspx?ID=<%# Eval("BlogID") %>' class="continue-btn">
                                    Continue Reading <i class="fas fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>