<%= form_with(url: sessions_path) do |form| %>
    <div>
        <%= form.label :login %>
        <%= form.text_field :login %>
    </div>

    <div>
        <%= form.label :password %>
        <%= form.password_field :password %>
    </div>

    <%= form.submit %>
<% end %>