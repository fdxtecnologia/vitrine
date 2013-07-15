/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.fdxtecnologia.vitrine.services.impl;

import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.fdxtecnologia.comparador.model.Market;
import java.util.List;

/**
 *
 * @author Andre
 */
@Resource
@Path("/market")
public class MarketServices {

    protected class SearchParams {

        private double lat;
        private double lng;
        private String zipCode;

        public double getLat() {
            return lat;
        }

        public void setLat(double lat) {
            this.lat = lat;
        }

        public double getLng() {
            return lng;
        }

        public void setLng(double lng) {
            this.lng = lng;
        }

        public String getZipCode() {
            return zipCode;
        }

        public void setZipCode(String zipCode) {
            this.zipCode = zipCode;
        }
    }

    /**
     *
     * @param params
     */
    @Post
    public void search(SearchParams params) {

        if (params.getZipCode() != null) {
            getMarketsByLatLng(params.getLat(), params.getLng());
        } else {
            getMarketsByZipCode(params.getZipCode());
        }
    }

    private List<Market> getMarketsByLatLng(double lat, double lng) {
        return null;
    }

    private List<Market> getMarketsByZipCode(String zipcode) {
        return null;
    }
}
