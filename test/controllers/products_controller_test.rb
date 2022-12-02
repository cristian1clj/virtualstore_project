require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path()

        assert_response :success
        assert_select '.product', 3
    end

    test 'render a detailed product page' do
        get product_path(products(:ps4))

        assert_response :success
        assert_select '.name', 'Ps4 Fat'
        assert_select '.description', 'Play 4 en buen estado'
        assert_select '.price', '1200000'
    end

    test 'render a new product form' do
        get new_product_path()
        assert_response :success
        assert_select 'form'
    end

    test 'allow to create a new product' do
        post products_path, params: {
            product: {
                title: 'Nintendo 64', 
                description: 'Le faltan los cables', 
                price: 450000, 
                category_id: categories(:videogames).id
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto de ha creado correctamente'
    end

    test 'Does not allow to create a new product with empty fields' do
        post products_path, params: {
            product: {
                title: '', 
                description: 'Le faltan los cables', 
                price: 450000
            }
        }

        assert_response :unprocessable_entity
    end

    test 'render an edit product form' do
        get edit_product_path(products(:ps4))
        assert_response :success
        assert_select 'form'
    end

    test 'allow to edit a new product' do
        patch product_path(products(:ps4)), params: {
            product: {
                price: 550000
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se ha actualizado'
    end

    test 'can delete products' do
        assert_difference('Product.count', -1) do
            delete product_path(products(:ps4))
        end

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
    end
end